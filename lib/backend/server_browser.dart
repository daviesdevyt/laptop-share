import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:cron/cron.dart';

class ServerBrowser {
  late RawDatagramSocket socket;
  Map<String, dynamic> servers = {};
  final cron = Cron();

  Future<void> broadcastClient() async {
    // Create a broadcast server
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4000);
    print('Broadcast server listening on port 4000');
    socket.broadcastEnabled = true;
    socket.listen((RawSocketEvent event) {
      var data = socket.receive();
      if (data != null) {
        Map<String, dynamic> serverInfo = json.decode(utf8.decode(data.data));
        servers[data.address.address] = serverInfo;
        print("Received message: $serverInfo");
      }
    });
  }

  ServerBrowser() {
    cron.schedule(Schedule.parse("*/3 * * * * *"), removeDullServers);
    broadcastClient();
  }

  void removeDullServers() {
    for (var server in servers.keys) {
      print(DateTime.now().millisecondsSinceEpoch - servers[server]["t"]);
      if (DateTime.now().millisecondsSinceEpoch - servers[server]["t"] > 3000) {
        servers.remove(server);
      }
    }
  }

  void close() {
    cron.close();
    socket.close();
  }

  void refresh() {
    servers.clear();
  }
}

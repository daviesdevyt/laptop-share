import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:cron/cron.dart';

class ServerBrowser {
  late RawDatagramSocket socket;
  List<Map> servers = [];
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
        serverInfo["ip"] = data.address;
        servers.add(serverInfo);
        print("Received message: $serverInfo");
      }
    });
  }

  ServerBrowser() {
    cron.schedule(Schedule.parse("*/2-3 * * * * *"), removeDullServers);
    broadcastClient();
  }

  void removeDullServers() {
    for (int i = 0; i < servers.length; ++i) {
      if (DateTime.now().millisecondsSinceEpoch - servers[i]["t"] > 3) {
        servers.remove(servers[i]);
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

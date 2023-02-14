import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:cron/cron.dart';

class ServerAdvertiser {
  late RawDatagramSocket socket;
  Map serverDetails = {"username": Platform.environment["USERNAME"]};
  final cron = Cron();
  bool connecting = false;

  ServerAdvertiser() {
    createBroadcastServer();
    cron.schedule(Schedule.parse("*/1 * * * * *"), broadcastServerDetails);
  }

  Future<void> createBroadcastServer() async {
    // Create a broadcast client
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 3000);
    socket.broadcastEnabled = true;
    socket.listen((RawSocketEvent event) {
      var data = socket.receive();
      if (data != null) {
        if (utf8.decode(data.data) == "<connect>") {
          connecting = true;
        }
      }
    });
  }

  void broadcastServerDetails() {
    serverDetails["t"] = DateTime.now().millisecondsSinceEpoch;
    socket.send(
      utf8.encode(json.encode(serverDetails)),
      InternetAddress("255.255.255.255"),
      4000,
    );
    print('Sent broadcast message: $serverDetails');
  }

  void close() {
    cron.close();
    socket.close();
  }
}

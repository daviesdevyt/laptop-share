import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:cron/cron.dart';

class ServerAdvertiser {
  late RawDatagramSocket socket;
  Map serverDetails = {"username": Platform.environment["USERNAME"]};
  final cron = Cron();

  ServerAdvertiser() {
    cron.schedule(Schedule.parse("*/1 * * * * *"), broadcastServer);
  }

  Future<void> broadcastServer() async {
    // Create a broadcast client
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;
    serverDetails["t"] = DateTime.now().millisecondsSinceEpoch;
    socket.send(
      utf8.encode(json.encode(serverDetails)),
      InternetAddress("255.255.255.255"),
      4000,
    );
    print('Sent broadcast message: $serverDetails');
  }

  void close() async {
    cron.close();
    socket.close();
  }
}
  
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class ServerAdvertiser {
  late RawDatagramSocket socket;
  Map serverDetails = {
    "username": Platform.environment["USERNAME"]
  };
  ServerAdvertiser() {
    runBroadcastClient();
  }

  Future<void> runBroadcastClient() async {
    // Create a broadcast client
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;
    socket.send(
      utf8.encode(json.encode(serverDetails)),
      InternetAddress("255.255.255.255"),
      4000,
    );
    print('Sent broadcast message: $serverDetails');
    socket.close();
  }
}

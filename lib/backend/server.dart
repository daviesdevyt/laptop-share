import 'dart:io';
import 'dart:convert';

class Server {
  late ServerSocket server;
  late String currentFileName;
  late IOSink sink;
  List<Socket> clients = [];

  Server() {
    ServerSocket.bind('0.0.0.0', 4000).then((serverSocket) {
      print("Server started");
      server = serverSocket;
      server.listen(_handleClientConnection);
    });
  }

  void _handleClientConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');
    clients.add(client);
    client.listen(
      _handleIncomingData,
      onError: (error) {
        print(error);
        server.close();
      },
      onDone: () {
        print("Done");
        sink.close();
      },
    );
  }

  void _handleIncomingData(data) async {
    try {
      String text = utf8.decode(data);
      if (text.substring(0, 7) == "<fname>") {
        currentFileName = text.substring(7, text.length);
        print(currentFileName);
        return;
      }
    } catch (e) {
      print(e);
    }
    File file = File(currentFileName);
    sink = file.openWrite();
    sink.add(data);
  }

  void sendFile(String path) async {
    File file = File(path);
    List<int> data = await file.readAsBytes();
    for (var client in clients) {
      client.add(utf8.encode("<fname>${file.uri.pathSegments.last}"));
      sleep(Duration(milliseconds: 500));
      client.add(data);
      print('File sent successfully');
    }
  }

  void close() {
    server.close();
  }
}

import 'dart:io';
import 'dart:convert';

class Client {
  late Socket client;
  late String currentFileName;
  late IOSink sink;

  Future<void> connect(ip) async {
    client = await Socket.connect(InternetAddress(ip), 4000);
    print('Connected to: ${client.remoteAddress.address}:${client.remotePort}');
    client.listen(
      _handleIncomingData,
      onError: (error) {
        print(error);
        client.destroy();
      },
      onDone: () {
        print("Done");
        sink.close();
      },
    );
  }

  void _handleIncomingData(data) {
    try {
      String text = utf8.decode(data);
      if (text.substring(0, 6) == "<fname>") {
        currentFileName = text.substring(7, text.length);
      }
    } catch (e) {
      print(e);
      File file = File(currentFileName);
      sink = file.openWrite();
      sink.add(data);
    }
  }

  void sendFile(String path) async {
    File file = File(path);
    List<int> data = await file.readAsBytes();
    client.add(utf8.encode("<fname>${file.uri.pathSegments.last}"));
    sleep(Duration(milliseconds: 500));
    client.add(data);
    print('File sent successfully');
  }

  void close() {
    client.close();
  }
}

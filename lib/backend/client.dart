import 'dart:io';
import 'dart:convert';

class Client {
  late Socket client;
  late String currentFileName;
  late IOSink sink;
  late String currentFileSize;

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

  void _handleIncomingData(data) async {
    try {
      String text = utf8.decode(data);
      if (text.substring(0, 7) == "<fname>") {
        currentFileName = text.substring(7, text.length);
        print(currentFileName);
        return;
      }
      if (text.substring(0, 7) == "<fsize>") {
        currentFileSize = text.substring(7, text.length);
        print(currentFileSize);
        return;
      }
    } catch (e) {}
    File file = await File(
            "C:\\Users\\${Platform.environment["username"]}\\Documents\\LaptopShare\\$currentFileName")
        .create(recursive: true);
    sink = file.openWrite();
    sink.add(data);
  }

  void sendFile(String path) async {
    File file = File(path);
    int totalFileSize = await file.length();
    int bytesSent = 0;

    RandomAccessFile inputFile = await file.open(mode: FileMode.read);
    final chunkSize = 1024 * 1024;

    client.add(utf8.encode("<fname>${file.uri.pathSegments.last}"));
    sleep(Duration(milliseconds: 500));

    while (bytesSent < totalFileSize) {
      List<int> data = await inputFile.read(chunkSize);
      client.add(data);
      bytesSent += data.length;
      print('Sent ${bytesSent / totalFileSize * 100}%');
      double progressValue = bytesSent / totalFileSize;

      setState(() {
        _progressValue = progressValue;
      });

      sleep(Duration(milliseconds: 500));
    } 
    await inputFile.close();

    print('File sent successfully');
  }

  void close() {
    client.close();
  }
}

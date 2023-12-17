import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class ShareFilesPage extends StatefulWidget {
  final server;

  const ShareFilesPage({super.key, required this.server});

  @override
  State<ShareFilesPage> createState() => _ShareFilesPageState();
}

class _ShareFilesPageState extends State<ShareFilesPage> {
  PlatformFile? _file;
  bool _isSendingFile = false;
  // bool _isSendingCancelled = false;
  String _sendingStatus = '';
  double _progressValue = 0;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = result.files.single;
      });
    }
  }

  Future<void> _sendFile() async {
    if (_file == null) return;
    widget.server.sendFile(_file!.path.toString());
    setState(() {
      _isSendingFile = true;
      _sendingStatus = 'Sending file...';
    });

    for (int i = 1; i <= 10; i++) {
      setState(() {
        _progressValue = i / 10;
      });
      await Future.delayed(Duration(milliseconds: 500));
    }

    setState(() {
      _sendingStatus = 'File sent!';
      _isSendingFile = false;
      _progressValue = 0;
    });
  }

  // void _cancelSending() {
  //   setState(() {
  //     _isSendingCancelled = true;
  //     _sendingStatus = 'Cancelling file sending...';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Lottie.asset(
                  "assets/lottie_anims/125890-laptop-file-transfer.json"),
            ),
            const SizedBox(height: 100),
            Container(
              child: ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(20),
                  ),
                ),
                onPressed: _pickFile,
                child: Text("Select file", style: AppStyles.headlineStyle2),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              child: Column(
                children: [
                  if (_file != null)
                    Text(
                      'Selected file: ${_file!.name}',
                      style: AppStyles.headlineStyle4,
                    ),
                  if (_isSendingFile)
                    LinearProgressIndicator(
                      value: _progressValue,
                      minHeight: 7,
                    ),
                  SizedBox(height: 20),
                  Text(_sendingStatus),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(20),
                  ),
                ),
                onPressed: _file == null ? null : _sendFile,
                child: Text("Send file", style: AppStyles.headlineStyle2),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_file != null) {
            setState(() {
              _file = null;
              _isSendingFile = false;
              _sendingStatus = '';
              _progressValue = 0;
            });
          }
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_rounded),
        backgroundColor: AppStyles.primaryOrange,
      ),
    );
  }
}

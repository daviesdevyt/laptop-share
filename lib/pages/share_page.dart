import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:laptop_share/utils/app_colors.dart';

class ShareFilesPage extends StatefulWidget {
  final server;

  const ShareFilesPage({super.key, required this.server});

  @override
  State<ShareFilesPage> createState() => _ShareFilesPageState();
}

class _ShareFilesPageState extends State<ShareFilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(20))),
          child: Text("Select file", style: AppStyles.headlineStyle2),
          onPressed: () async {
            FilePickerResult? file = await FilePicker.platform.pickFiles();
            if (file == null) return;
            widget.server.sendFile(file.files.single.path.toString());
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laptop_share/backend/client.dart';
import 'package:laptop_share/backend/server_browser.dart';
import 'package:laptop_share/pages/share_page.dart';
import 'package:laptop_share/utils/app_colors.dart';

class HostComponent extends StatelessWidget {
  final String username;
  final String ip;
  final ServerBrowser server;

  const HostComponent(
      {super.key,
      required this.username,
      required this.ip,
      required this.server});

  @override
  Widget build(BuildContext context) {
    String icon = username.substring(0, 1);
    return Column(children: [
      MaterialButton(
        onPressed: () async {
          server.sendConnect(ip);
          Client client = Client();
          await client.connect(ip).then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShareFilesPage(server: client)),
              ));
        },
        shape: const CircleBorder(),
        height: 80,
        color: AppStyles.primaryPurple,
        child: Text(icon.toUpperCase(),
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      Text(
        username,
        style: AppStyles.headlineStyle3,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      )
    ]);
  }
}

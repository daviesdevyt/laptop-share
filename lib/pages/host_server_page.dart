import 'package:flutter/material.dart';
import 'package:laptop_share/backend/server.dart';
import 'package:laptop_share/backend/server_advertiser.dart';
import 'package:laptop_share/pages/share_page.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:cron/cron.dart';

class ServerWaitRoom extends StatefulWidget {
  const ServerWaitRoom({super.key});

  @override
  State<ServerWaitRoom> createState() => _ServerWaitRoomState();
}

class _ServerWaitRoomState extends State<ServerWaitRoom> {
  final ServerAdvertiser _serverAdvertiser = ServerAdvertiser();
  final cron = Cron();
  var server;

  void isConnecting() {
    if (_serverAdvertiser.connecting && server == null) {
      _serverAdvertiser.close();
      server = Server();
    } else if (server != null && server.clients.isNotEmpty) {
      cron.close();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShareFilesPage(server: server)),
      );
    }
  }

  _ServerWaitRoomState() {
    cron.schedule(Schedule.parse("*/1 * * * * *"), isConnecting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            children: [
              Lottie.network(
                  "https://assets1.lottiefiles.com/packages/lf20_pmqt2q8c.json"),
              Text("Waiting for connections ...",
                  style: AppStyles.headlineStyle2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _serverAdvertiser.close();
          Navigator.pop(context);
        },
        backgroundColor: AppStyles.primaryOrange,
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}

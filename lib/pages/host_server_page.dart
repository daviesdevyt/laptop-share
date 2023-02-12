import 'package:flutter/material.dart';
import 'package:laptop_share/backend/server_advertiser.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class ServerWaitRoom extends StatefulWidget {
  const ServerWaitRoom({super.key});

  @override
  State<ServerWaitRoom> createState() => _ServerWaitRoomState();
}

class _ServerWaitRoomState extends State<ServerWaitRoom> {
  final ServerAdvertiser _serverAdvertiser = ServerAdvertiser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
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
        child: Icon(Icons.arrow_back_ios_new_rounded),
        backgroundColor: AppStyles.primaryOrange,
      ),
    );
  }
}

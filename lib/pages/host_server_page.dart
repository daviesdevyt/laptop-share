import 'package:flutter/material.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:laptop_share/widgets/load_component.dart';

class ServerWaitRoom extends StatefulWidget {
  const ServerWaitRoom({super.key});

  @override
  State<ServerWaitRoom> createState() => _ServerWaitRoomState();
}

class _ServerWaitRoomState extends State<ServerWaitRoom> {
  int connectionCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 120),
        child: Center(
          child: Column(
            children: [
              const LoadBar(),
              SizedBox(height: 30),
              Text("Devices Connected: $connectionCount",
                  style: AppStyles.headlineStyle2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_rounded),
        backgroundColor: AppStyles.primaryOrange,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laptop_share/utils/app_colors.dart';

class HostComponent extends StatelessWidget {
  final String username;

  const HostComponent({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    String icon = this.username.substring(0, 1);
    return Container(
        child: Column(children: [
      MaterialButton(
        onPressed: () {},
        color: AppStyles.primaryPurple,
        child: Text(
          icon.toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        shape: CircleBorder(),
        height: 80,
      ),
      Text(username, style: AppStyles.headlineStyle3, textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,)
    ]));
  }
}

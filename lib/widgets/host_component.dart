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
        color: Colors.blue,
        child: Text(
          icon,
          style: AppStyles.headlineStyle1,
          overflow: TextOverflow.ellipsis,
        ),
        shape: CircleBorder(),
        height: 80,
      ),
      Text(username, style: AppStyles.headlineStyle3, textAlign: TextAlign.center,)
    ]));
  }
}

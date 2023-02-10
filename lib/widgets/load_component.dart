import 'package:flutter/material.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LoadBar extends StatefulWidget {
  const LoadBar({super.key});

  @override
  State<LoadBar> createState() => _LoadBarState();
}

class _LoadBarState extends State<LoadBar> {
  final double size = 200;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: AppStyles.primaryOrange,
        strokeWidth: 30,
      ),
    );
  }
}

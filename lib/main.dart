import 'package:flutter/material.dart';
import 'package:laptop_share/pages/home_page.dart';
import 'package:laptop_share/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laptop Share',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppStyles.bgColor
      ),
      home: const HomePage(),
    );  
  }
}
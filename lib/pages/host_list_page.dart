import 'package:flutter/material.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:laptop_share/widgets/host_component.dart';

class HostListPage extends StatefulWidget {
  const HostListPage({super.key});

  @override
  State<HostListPage> createState() => _HostListPageState();
}

class _HostListPageState extends State<HostListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 56, 56, 56)),
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: List.generate(17, (index) {
            return HostComponent(
              username: "Davies Dev",
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios_new_rounded), backgroundColor: AppStyles.primaryOrange,
      ),
    );
  }
}

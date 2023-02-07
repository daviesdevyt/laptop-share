import 'package:flutter/material.dart';
import 'package:laptop_share/pages/host_list_page.dart';
import 'package:laptop_share/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text("Laptop Share", style: AppStyles.headlineStyle1),
              SizedBox(height: 20),
              Text(
                "Share files to anybody connected to your same WiFi network",
                style: AppStyles.headlineStyle4,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HostListPage()),
                  );
                },
                child: Ink.image(
                  image: AssetImage(
                    "assets/images/send_btn.png",
                  ),
                  height: 100,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {},
                child: Ink.image(
                  image: AssetImage(
                    "assets/images/recieve_btn.png",
                  ),
                  height: 100,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

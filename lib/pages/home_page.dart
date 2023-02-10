import 'package:flutter/material.dart';
import 'package:laptop_share/pages/host_list_page.dart';
import 'package:laptop_share/pages/host_server_page.dart';
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
              const SizedBox(height: 70),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServerWaitRoom()),
                  );
                },
                borderRadius: BorderRadius.circular(40),
                child: Ink.image(
                  image: const AssetImage(
                    "assets/images/send_btn.png",
                  ),
                  height: 100,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
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
                borderRadius: BorderRadius.circular(40),
                child: Ink.image(
                  image: const AssetImage("assets/images/recieve_btn.png",),
                  height: 100,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

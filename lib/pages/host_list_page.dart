import 'package:flutter/material.dart';
import 'package:laptop_share/backend/server_browser.dart';
import 'package:laptop_share/utils/app_colors.dart';
import 'package:laptop_share/widgets/host_component.dart';
import 'package:cron/cron.dart';

class HostListPage extends StatefulWidget {
  const HostListPage({super.key});

  @override
  State<HostListPage> createState() => _HostListPageState();
}

class _HostListPageState extends State<HostListPage> {
  final ServerBrowser _serverBrowser = ServerBrowser();
  List<Widget> servers = [];

  void refreshHosts() {
    List<Widget> newList = [];
    servers.clear();
    for (var ip in _serverBrowser.servers.keys) {
      newList.add(
        HostComponent(username: _serverBrowser.servers[ip]["username"]));
    }
    setState(() {
      servers = newList;
    });
  }

  final cron = Cron();

  _HostListPageState() {
    cron.schedule(Schedule.parse('*/2 * * * * *'), refreshHosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 56, 56, 56)),
        child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: servers),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cron.close();
          _serverBrowser.close();
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_rounded),
        backgroundColor: AppStyles.primaryOrange,
      ),
    );
  }
}

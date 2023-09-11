import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer(){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://www.shareicon.net/data/512x512/2016/06/30/788937_people_512x512.png'),
            ),
            accountName: Text('Georgy'), 
            accountEmail: Text('jorgeluis280801@gmail.com')
            ),
            ListTile(
              leading: Image.network('https://www.verstappen.com/img/thumb/thumb.php?src=/img/product/481_ea2db20_12202101_Front_1.png'),
              trailing: Image.network('https://cutewallpaper.org/24/modern-arrow-png/download-red-arrow-free-png-transparent-image-and-clipart.png'),
              title: Text('Drivers'),
              subtitle: Text('Drivers stats'),
              onTap: () {},
            ),
            DayNightSwitcher(
              isDarkModeEnabled: GlobalValue.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) {
                GlobalValue.flagTheme.value = isDarkModeEnabled;
              },
            ),
        ],
      ),
    );
  }
}
import 'dart:async';

import 'package:concentric_transition/concentric_transition.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/tarjetas.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: ConcentricPage(),
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
            accountName: Text('Georgy28'),
            accountEmail: Text('jorgeluis280801@gmail.com')
            ),
            ListTile(
              leading: Image.network('https://cdn3.iconfinder.com/data/icons/circle-f1/512/F1_1-256.png'),
              trailing: Image.network('https://cutewallpaper.org/24/modern-arrow-png/download-red-arrow-free-png-transparent-image-and-clipart.png'),
              title: Text('Mercancia'),
              subtitle: Text('Vistete con los colores de tu equipo!'),
              onTap: () {
                Navigator.pushNamed(context, '/prod_det');
              },
            ),
            ListTile(
              leading: Image.network('https://cdn3.iconfinder.com/data/icons/circle-f1/512/F1_19-256.png'),
              trailing: Image.network('https://cutewallpaper.org/24/modern-arrow-png/download-red-arrow-free-png-transparent-image-and-clipart.png'),
              title: Text('TaskScreen'),
              subtitle: Text('BD de los pilotos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            DayNightSwitcher(
              isDarkModeEnabled: GlobalValue.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {
                final SharedPreferences pref = await SharedPreferences.getInstance();
                GlobalValue.flagTheme.value = isDarkModeEnabled;
                pref.setBool('theme', isDarkModeEnabled);
              },
            ),
            MaterialButton(
              color: Color.fromARGB(255, 139, 0, 0),
              child: const Text('Cerrar sesion',
                     style: TextStyle(color: Colors.white),),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('Recuerdame');
                prefs.remove('theme');
                Navigator.pushNamed(context, '/login');
              },
            )
        ],
      ),
    );
  }
}

class ConcentricPage extends StatelessWidget {
  ConcentricPage({Key? key}):super(key: key);

  final data =  [
    tarjetasDat(
      title: "Eres un verdadero fan de la F1?", 
      subtitle: "Entonces aqui tenemos todo lo que deseas", 
      image: AssetImage('assets/images/P1.jpg'), 
      backgroundColor: Color.fromARGB(255, 16, 6, 121), 
      titleColor: Color.fromARGB(255, 243, 36, 36), 
      subtitleColor: Color.fromARGB(253, 223, 235, 7),
      background: LottieBuilder.asset("assets/animations/AP1.json"),
      ),
      tarjetasDat(
      title: "Ponte al dia con las estadisticas de la temporada!", 
      subtitle: "Pilotos, escuderias, posiciones, etc....", 
      image: AssetImage('assets/images/P2.jpg'),
      backgroundColor: Color.fromARGB(255, 0, 0, 0), 
      titleColor: Color.fromARGB(255, 20, 255, 192), 
      subtitleColor: Color.fromARGB(252, 116, 116, 116),
      background: LottieBuilder.asset("assets/animations/AP2.json"),
      ),
      tarjetasDat(
      title: "Consigue mercancia de tu equipo favorito!", 
      subtitle: "Playeras, sudaderas, cascos, etc....", 
      image: AssetImage('assets/images/P3.jpg'),
      backgroundColor: Color.fromARGB(255, 255, 0, 0), 
      titleColor: Color.fromARGB(255, 234, 255, 0), 
      subtitleColor: Color.fromARGB(251, 0, 0, 0),
      background: LottieBuilder.asset("assets/animations/AP3.json"),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
       colors: data.map((e) => e.backgroundColor).toList(),
       itemCount: data.length,
       itemBuilder: (int index) {{}
         return tarjetas(data: data[index]);
       },
    ),
    );
  }
}
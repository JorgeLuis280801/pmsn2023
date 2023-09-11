import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController txtconUser = TextEditingController();
    TextEditingController txtconPass = TextEditingController();

    final txtUser = TextField(
      controller: txtconUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
      
    );

    final txtPass = TextField(
      controller: txtconPass,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final imgLogo = Container(
      height: 200,
      width: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://wallpaperaccess.com/full/2180256.png')
            )
        ),
    );
  
    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: (){
        Navigator.pushNamed(context, '/dash');
      }
      );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            'https://www.hdwallpapers.in/download/black_pattern_red_white_4k_hd_abstract-720x1280.jpg')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 200,
                child: imgLogo),
              Container(
                height: 200,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 4, 2, 17),
                ),
                child: Column(
                  children: [  
                    txtUser,
                    const SizedBox(height: 10),
                    txtPass
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}
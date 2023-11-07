import 'package:flutter/material.dart';
import 'package:pmsn2023/firebase/email_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool? Marcado = false;

  final txtconUser = TextEditingController();
  final txtconPass = TextEditingController();

  final emailAuth = EmailAuth();
  
  @override
  Widget build(BuildContext context) {

    final txtUser = TextField(
      controller: txtconUser,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );

    final txtPass = TextField(
      controller: txtconPass,
      obscureText: true,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
      ),
      style: const TextStyle(color: Colors.white),
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
      icon: const Icon(Icons.login),
      label: const Text('Entrar'),
      /*onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('Recuerdame', Marcado ?? false);
        Navigator.pushNamed(context, '/dash');
      }*/
      onPressed: () async {
        bool res = await emailAuth.verifyUsr(email: txtconUser.text, pwdUser: txtconPass.text);
        if (res) {
          Navigator.pushNamed(context, '/dash');
        }
      },
      );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/fondo.jpg')
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: 
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 200,
                child: 
                imgLogo,),
              Container(
                height: 246,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 4, 2, 17),
                ),
                child: Column(
                  children: [  
                    txtUser,
                    const SizedBox(height: 10),
                    txtPass,
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: Marcado, 
                          onChanged: (isMarcado) { 
                            setState(() {
                              Marcado = isMarcado;
                            });
                          }
                        ),
                        const Text('Recuerdame',
                        style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: ()=>Navigator.pushNamed(context, '/reg'), 
                child: Text("Registrase :D", style: TextStyle(fontSize: 30),)
              ),
            ],
          ),
        ),              
      ),     
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: btnEntrar,
    );
  }
}
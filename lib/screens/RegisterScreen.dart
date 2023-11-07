import 'package:flutter/material.dart';
import 'package:pmsn2023/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPwdUser = TextEditingController();

  final emailauth = EmailAuth();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro usuario5')),
      body: Column(
        children: [
          TextFormField(
            controller: conNameUser,
          ),
          TextFormField(
            controller: conEmailUser,
          ),
          TextFormField(
            controller: conPwdUser,
          ),
          ElevatedButton(
            onPressed: (){
              String email = conEmailUser.text;
              String pwd = conPwdUser.text;
              emailauth.createUser(email: email, pwdUser: pwd);
            }, 
            child: Text('Registrarme')
          )
        ],
      ),
    );
  }
}
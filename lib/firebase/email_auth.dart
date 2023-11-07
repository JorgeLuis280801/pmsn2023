import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser({
    required String email,
    required String pwdUser
  }) async {
    try {
      final usrCredentials = await auth.createUserWithEmailAndPassword(email: email, password: pwdUser);
      usrCredentials.user!.sendEmailVerification();
      print('Si jalo al parecer :v');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyUsr({
    required String email,
    required String pwdUser
  }) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(email: email, password: pwdUser);
      if (credentials.user!.emailVerified) {
        return true;
      }else{
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }

}
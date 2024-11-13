import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


  //instancia de autenticacion
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signInWhithEmailPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
        );
        return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sing up

  //sing out

  // errorres

}
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


  //instancia de autenticacion
  final FirebaseAuth _auth =  FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email,password) async{
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
  Future<UserCredential> signUpWithEmailPassword(String email,password) async{
    try{
      UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sing out
  Future<void>signOut() async{
    return await _auth.signOut();
  }

  // errorres

}
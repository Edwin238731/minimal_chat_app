import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


  //instancia de autenticacion y firestore
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }


  //sign in
  Future<UserCredential> signInWithEmailPassword(String email,password) async{
    try{
      //sing user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
        );
        //save user info if it doesn't already exist
        _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
        );

        return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sing up
  Future<UserCredential> signUpWithEmailPassword(String email,password) async{
    try{
      //crear usuario
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        //guardar informacion del usuario
        _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
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
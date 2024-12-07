import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instancia de autenticacion y firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  //*Indica que esta función es asíncrona y devolverá un objeto UserCredential en el futuro.
  //*/
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    /*La palabra clave async se utiliza para definir una función asíncrona,
    una función que realiza tareas que pueden tomar algún tiempo para completarse,
    como operaciones de red, lectura/escritura de archivos o llamadas a bases de datos.*/
    try {
      //sing user in
      //**_auth.signInWithEmailAndPassword: Método de Firebase para autenticar usuarios con correo electrónico y contraseña.
      //await: Espera a que se complete la operación asíncrona antes de continuar con el código.
      //UserCredential userCredential: Almacena el objeto devuelto por Firebase, que contiene información sobre el usuario autenticado. */
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save user info if it doesn't already exist
      //**_firestore: Referencia a la base de datos Firestore.
      //.collection("users"): Accede a la colección users en Firestore.
      //.doc(userCredential.user!.uid): Selecciona o crea un documento con el uid único del usuario autenticado. */
      _firestore.collection("users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,//userCredential.user!: Indica que user no es nulo. El operador ! es necesario porque Dart usa seguridad nula.
        'email': email,
        //**.set({ ... }): Guarda un mapa de datos en el documento especificado.
        //  'uid': userCredential.user!.uid: Guarda el identificador único del usuario.
        //  'email': email: Guarda el correo electrónico del usuario.
        // */
      });

      return userCredential;//on FirebaseAuthException: Atrapa únicamente errores de tipo FirebaseAuthException.
    } on FirebaseAuthException catch (e) {//catch(e): Captura el error y lo almacena en la variable e.
      throw Exception(e.code);//throw Exception(e.code): Lanza una nueva excepción con el código de error para que pueda ser manejada fuera de esta función.
    }
  }

  //sing up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    //La palabra clave async se utiliza para definir una función asíncrona
    try {
      //crear usuario
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
//_auth.createUserWithEmailAndPassword: Método de Firebase Authentication para registrar un usuario nuevo con correo y contraseña.
        email: email,
        password: password,
      );
      //guardar informacion del usuario
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
//.collection("Users"): Selecciona o crea la colección Users en Firestore para almacenar datos de los usuarios.
        'uid': userCredential.user!.uid,
//userCredential.user!: Garantiza que el objeto user no es nulo (el operador ! es necesario debido a la seguridad nula en Dart).
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {//catch(e): Captura el error y lo almacena en la variable e.
      throw Exception(e.code); //throw Exception(e.code): Lanza una nueva excepción con el código de error para que pueda ser manejada fuera de esta función.
    }
  }

  //sing out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // errorres
}

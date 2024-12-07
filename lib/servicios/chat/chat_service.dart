import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat_app/models/menssage.dart';

class ChatService {
//get instance of fire store
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
// get user stream
Stream<List<Map<String,dynamic>>> getUsersStream() {
  /* Representa una secuencia de eventos o datos que se emiten de forma asíncrona a lo largo del tiempo.
En este caso, el método devuelve un flujo de datos que representa una lista de usuarios. */
  /*
  consulta en la base de datos,
  Users es la coleccion de registros,
  el equivalente a una tabla en sql
  No mover
  */
  return _firestore.collection("Users").snapshots().map((snapshot){
//.snapshots():Crea un Stream que emite actualizaciones en tiempo real de la colección "Users".
//Cada vez que cambia un documento en la colección, se emite un nuevo QuerySnapshot.
    return snapshot.docs.map((doc) {
/* .map((snapshot) { ... }):
Transforma los eventos emitidos por el flujo original (QuerySnapshot) en un nuevo tipo de flujo.
Cada snapshot representa el estado actual de la colección "Users".

snapshot.docs:
Devuelve una lista de documentos (QueryDocumentSnapshot) dentro del snapshot.

.map((doc) { ... }):
Itera sobre cada documento de la lista y aplica una transformación para extraer los datos del usuario. */
      final user = doc.data();
/*doc.data():
Extrae los datos del documento actual como un mapa (Map<String, dynamic>).
Este mapa contiene los campos y valores asociados con el registro del usuario en Firestore. */
      return user;
    }).toList();//.toList():Convierte el iterable que resulta de docs.map(...) en una lista (List<Map<String, dynamic>>).
  });
}
// enviar mensaje
Future<void> sendMenssage(String receiverID, message) async{
  // get current user info
  final String currentUserID = _auth.currentUser!.uid;//Obtiene el identificador único del usuario que está actualmente autenticado
  final String currentUserEmail = _auth.currentUser!.email!;//Obtiene el correo electrónico del usuario autenticado
  final Timestamp timestamp = Timestamp.now();//Registra la fecha y hora actuales como un Timestamp de Firebase,
  //que se usará para marcar el momento del envío del mensaje.
  //create a  new message
  Message newMessage =  Message(
    senderID: currentUserID,
    senderEmail: currentUserEmail ,
    receiverID: receiverID ,
    message: message ,
    timestamp: timestamp ,
/* Message: Es un objeto que encapsula los detalles del mensaje que se está enviando.
Incluye:
senderID: ID del remitente.
senderEmail: Correo electrónico del remitente.
receiverID: ID del destinatario.
message: El contenido del mensaje.
timestamp: Fecha y hora del envío.*/
  );
  //
  List<String> ids = [currentUserID, receiverID];//ids: Se crea una lista con los IDs del remitente y del destinatario.
  ids.sort();//ids.sort(): Ordena los IDs alfabéticamente para garantizar que el chatRoomID sea único
  //y consistente, sin importar quién inicia el mensaje.
  String chatRoomID = ids.join('_');
  // ids.join('_'): Combina los IDs ordenados usando un guion bajo como separador, creando un identificador único para el chat.
  // add new message database
  await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());
/* _firestore.collection("chat_rooms"): Accede a la colección principal que contiene todos los "chatrooms".
.doc(chatRoomID): Accede (o crea, si no existe) un documento único identificado por chatRoomID.
.collection("messages"): Dentro de este documento, accede a una subcolección llamada messages que contendrá todos los mensajes del chat.
.add(newMessage.toMap()): Agrega el mensaje a la subcolección.
newMessage.toMap(): Convierte el objeto Message a un mapa (Map<String, dynamic>) compatible con Firestore. */
}

//recibir mensaje
Stream<QuerySnapshot> getMessages(String userID, otherUserID){
  //constructor a chatroom ID from the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
      .collection("chat_rooms")//Accede a la colección principal llamada chat_rooms, que contiene todas las salas de chat.
      .doc(chatRoomID)//Selecciona el documento cuyo ID coincide con el chatRoomID.
      .collection("messages")//Dentro de cada sala de chat (chatRoomID), existe una subcolección llamada messages que almacena los mensajes intercambiados.
      .orderBy("timestamp",  descending: false)
//Ordena los mensajes por la marca de tiempo (timestamp) en orden ascendente (de más antiguo a más reciente). Esto asegura que los mensajes se muestren en el orden correcto.
      .snapshots();//Devuelve un Stream que emite actualizaciones en tiempo real cada vez que los datos cambian en la subcolección messages.
/* QuerySnapshot: Si estás escuchando una colección, se devuelve un conjunto de documentos.
DocumentSnapshot: Si estás escuchando un documento único, se devuelve solo ese documento. */
  }
}
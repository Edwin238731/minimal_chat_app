import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat_app/models/menssage.dart';

class ChatService {
//get instance of fire store
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
// get user stream
/*

List<Map<String,dynamic> =
[
{
  'email': test@gmail.com,
  'id' : ..
},
{
  'email': chucho@gmail.com,
  'id' : ..
},
]
*/
Stream<List<Map<String,dynamic>>> getUsersStream() {
  /*
  consulta en la base de datos,
  Users es la coleccion de registros,
  el equivalente a una tabla en sql
  No mover
  */
  
  return _firestore.collection("Users").snapshots().map((snapshot){
    return snapshot.docs.map((doc) {
      //go through each individual user
      final user = doc.data();
      
      //return user
      return user;
    }).toList();
  });
}
// enviar mensaje
Future<void> sendMenssage(String receiverID, message) async{
  // get current user info
  final String currentUserID = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();
  //create a  new message
  Message newMessage =  Message(
    senderID: currentUserEmail,
    senderEmail: currentUserID ,
    receiverID: receiverID ,
    message: message ,
    timestamp: timestamp ,

  );
  //constructor chad room ID For the two users (stored to ensure uniqueness)
  List<String> ids = [currentUserID, receiverID];
  ids.sort();//sort the ids (this ensure the chatroomID is the seme for any 2 people)
  String chatRoomID = ids.join('_');
  // add new message database
  await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());

}

//recibir mensaje
Stream<QuerySnapshot> getMessages(String userID, otherUserID){
  //constructor a chatroom ID from the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .orderBy("timestamp",  descending: false)
      .snapshots();
}

}
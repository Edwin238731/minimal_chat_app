import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
//get instance of fire store
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  return _firestore.collection("Usuarios").snapshots().map((snapshot){
    return snapshot.docs.map((doc) {
      //go through each individual user
      final user = doc.data();
      
      //return user
      return user;
    }).toList();
  });
}
// enviar mensaje

//recibir mensaje

}
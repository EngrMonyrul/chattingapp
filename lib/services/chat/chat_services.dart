import 'package:chattingapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return data;
      }).toList();
    });
  }

  Future<void> sendMessage(
      {required String reciverId, required String messageBody}) async {
    final senderUid = _auth.currentUser!.uid;
    final senderEmail = _auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    Message message = Message(
      senderID: senderUid,
      senderEmail: senderEmail,
      timeStamp: timestamp,
      message: messageBody,
      receiverID: reciverId,
    );

    List<String> ids = [senderUid, reciverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toJson());
  }

  Stream<QuerySnapshot> getMessages({required String receiverId}) {
    final senderUid = _auth.currentUser!.uid;
    List<String> ids = [senderUid, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}

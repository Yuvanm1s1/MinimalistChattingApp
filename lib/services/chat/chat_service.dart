import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatapp/model/message.dart';
class ChatService{
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user stream

  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }


  //send message
  Future<void> sendMessage(String recieverId , message) async{
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    String currentUserEmail = _auth.currentUser!.email ?? '';
    final Timestamp timestamp = Timestamp.now();
    //create new message
    Message newMessage = Message(senderID: currentUserId, senderEmail: currentUserEmail, revieverID: recieverId, message: message, timestamp: timestamp);
    //construct chat room id
    List<String> ids = [currentUserId,recieverId];
    ids.sort();
    String chatRoomID = ids.join('_');
    //add new message to database
    await _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(newMessage.toMap());
  }
  //get message

Stream<QuerySnapshot> getMessage(String userID , otherUserID){
    List<String> ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp",descending: false).snapshots();
}
}
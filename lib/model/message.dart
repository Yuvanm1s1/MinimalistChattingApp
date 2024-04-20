import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Message{
  late final String senderID;
  late final String senderEmail;
  late final String revieverID;
  late final String message;
  late final Timestamp timestamp;

  Message({required this.senderID,
    required this.senderEmail,
    required this.revieverID,
    required this.message,
    required this.timestamp});

  Map<String,dynamic> toMap(){
    return{
      'senderID': senderID,
      'senderEmail': senderEmail,
      'revieverID': revieverID,
      'message' :message,
      'timestamp': timestamp,
    };
  }

}
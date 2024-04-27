import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/message_model.dart';

class ChatService{
  
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;


  Future<void> sendChatMessage({required String message , required String touserName}) async {
    var messageModel = {
      'message': message,
      'to': touserName,
      'uuid': FirebaseAuth.instance.currentUser!.uid,
      'time': Timestamp.now(),
    };
    await FirebaseFirestore.instance.collection('chat').add(messageModel);

  }


  
}
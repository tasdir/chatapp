import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatpage.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages')
            .where('uuid', isEqualTo: _auth.currentUser!.uid) // Messages sent by the user
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No messages found"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var message = snapshot.data!.docs[index];
              return ListTile(
                title: Text(message['to']), // Displaying the recipient's user ID
                subtitle: Text(message['message']),
                trailing: Text(message['time'].toDate().toString()),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChatPage(chatId: message.id) // Passing the message ID
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

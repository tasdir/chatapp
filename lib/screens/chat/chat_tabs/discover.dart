
import 'package:chat_app/screens/chat/chat_tabs/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No users found"));
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var user = snapshot.data.docs[index];

              String userName = user['name']; // Fetching the name of the user
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage(userName: userName ))); // Assuming ChatPage takes a userId parameter
                  print(userName);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[user['name'].hashCode % Colors.primaries.length],
                    child: Text(
                      user['name'].isNotEmpty ? user['name'].substring(0, 1).toUpperCase() : '?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user['name'] ?? 'No Name'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
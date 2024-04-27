import 'package:flutter/material.dart';
class ChatBubble extends StatefulWidget {
  final Color color;
  const ChatBubble({super.key, required this.color});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: widget.color,
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return ChatsPage(userName: 'user2',);
//   }
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.primaries[userName.hashCode % Colors.primaries.length],
//         child: Text(userName.substring(0, 1).toUpperCase()), // Display the first letter of the name
//       ),
//       title: Text(userName),
//       subtitle: Text(message),
//     );
//   }
// }



//
//
// class _ChatsPageState extends State
// {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat'),
//         backgroundColor: Colors.blue,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData) {
//             return Center(child: Text("No users found"));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               var user = snapshot.data.docs[index];
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage(userId: user.username))); // Assuming ChatPage takes a userId parameter
//                   print(user.username);
//                 },
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.primaries[user['name'].hashCode % Colors.primaries.length],
//                     child: Text(
//                       user['name'].isNotEmpty ? user['name'].substring(0, 1).toUpperCase() : '?',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   title: Text(user['name'] ?? 'No Name'),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//         stream: FirebaseFirestore.instance.collection('chat').orderBy('time').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot
//
//         snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData) {
//             return Center(child: Text("No data available"));
//           }
//
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var doc = snapshot.data!.docs[index];
//               return ChatBubble(
//                 userName: doc['userName'], // Assuming 'userName' is stored in each document
//                 message: doc['message'],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
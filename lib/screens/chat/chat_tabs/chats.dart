import 'package:chat_app/const_config/text_config.dart';
import 'package:chat_app/widgets/custom_buttons/Rouded_Action_Button.dart';
import 'package:chat_app/widgets/input_widgets/simple_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../../services/chat_service.dart';


class ChatsPage extends StatefulWidget {
  final String userName;  // Declare userName as a final member variable

  const ChatsPage({super.key, required this.userName});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final firebase = FirebaseFirestore.instance;
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userName), // Use the userName in the AppBar title
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firebase.collection('chat').orderBy('time').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
                    var data = snapshot.data.docs;
                    return data.length != 0
                        ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data.docs[index]['message']),
                            ),),
                        );
                      },
                    )
                        : const Center(child: Text("No Chats to show"));
                  } else {
                    return const Center(
                      // child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SimpleInputField(
              controller: messageController,
              hintText: "Aa..",
              needValidation: true,
              errorMessage: "Message box can't be empty",
              fieldTitle: "",
              needTitle: false,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedActionButton(
              onClick: () {
                ChatService().sendChatMessage(message: messageController.text ,  touserName: widget.userName);
              },
              label: "Send Message",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

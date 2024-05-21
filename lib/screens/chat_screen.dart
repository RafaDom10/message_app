import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:message_app/services/google_sign_in.dart';
import 'package:message_app/widgets/chat_message.dart';
import 'package:message_app/widgets/message_composer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _loading = false;

  void sendMessage({String? message, File? image}) async {
    Map<String, dynamic> data = {
      'uuid': user?.uid,
      'displayName': user?.displayName,
      'photoURL': user?.photoURL,
      'time': Timestamp.now()
    };
    data['message'] = message;

    if (image != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(user!.uid + DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(image);

      setState(() {
        _loading = true;
      });

      final TaskSnapshot downloadURL = (await task);
      final String url = await downloadURL.ref.getDownloadURL();

      data['photoURL'] = url;
    }

    FirebaseFirestore.instance.collection('messages').add(data);
  }

  void _onPressed(context) {
    FirebaseAuth.instance.signOut();
    signOutGoogle();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Logout succeed'),
      backgroundColor: Colors.green,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '${user?.displayName}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _onPressed(context),
            icon: const Icon(Icons.exit_to_app_rounded),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .orderBy('time')
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> documents =
                      snapshot.data!.docs.reversed.toList();
                  return ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ChatMessage(
                            data: documents[index].data(),
                            self: documents[index].data()['uid'] == user?.uid);
                      },
                      itemCount: documents.length);
              }
            },
          )),
          _loading ? const LinearProgressIndicator() : Container(),
          MessageComposer(sendMessage)
        ],
      ),
    );
  }
}

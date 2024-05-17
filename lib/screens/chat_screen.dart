import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/services/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
    );
  }
}

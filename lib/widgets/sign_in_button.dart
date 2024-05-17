import 'package:flutter/material.dart';
import 'package:message_app/screens/chat_screen.dart';
import 'package:message_app/services/google_sign_in.dart';

Widget signInButton(BuildContext context) {
  void onPressed() {
    signInWithGoogle().then((value) => {
          if (value != null)
            {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatScreen()))
            }
        });
  }

  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.grey,
        side: const BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
    child: const Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/g_logo.jpg'), height: 35.0),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Entrar com Google',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          )
        ],
      ),
    ),
  );
}

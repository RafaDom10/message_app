import 'package:flutter/material.dart';
import 'package:message_app/screens/chat_screen.dart';
import 'package:message_app/services/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.message_outlined,
                color: Colors.green,
                size: 150.0,
              ),
              const SizedBox(
                height: 100.0,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : signInButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    void onPressed() {
      setState(() {
        isLoading = true;
      });
      signInWithGoogle().then((value) => {
            if (value != null)
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ChatScreen()))
              },
            setState(() {
              isLoading = false;
            })
          });
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.green),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
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
}

import 'package:flutter/material.dart';
import 'package:message_app/widgets/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              signInButton(context)
            ],
          ),
        ),
      ),
    );
  }
}

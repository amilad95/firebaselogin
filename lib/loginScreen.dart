import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  Future loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
      print("User logged in successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Form(
          child: Column(
        children: [
          TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "enter email here")),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
              controller: _pass,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter password here")),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Text("Login Now"))
        ],
      )),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  Future registerUser() async {
    try {
      print('aaaaa');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _pass.text);

      print("User Register Successfully....");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Screen'),
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
                registerUser();
              },
              child: Text("Register"))
        ],
      )),
    );
  }
}

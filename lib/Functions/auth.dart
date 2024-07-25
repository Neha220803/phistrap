import 'package:flutter/material.dart';
import 'package:phistrap/Pages/home_page.dart';

Future<void> signInWithEmailAndPassword(context) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     print("${_emailController.text}");
  //     print("${_passwordController.text}");
  //     print("success");

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       _loginMessage = e.message ?? 'An error occurred';
  //     });

  //     if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('You have entered a wrong password.'),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/LoginPage.dart';
import 'package:firebase_flutter/ui/homepage/HomePage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  routs() {
    Timer(const Duration(seconds: 3), () {
      firebaseAuth.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    routs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF619BE3),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset('images/firebase.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Firebase',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

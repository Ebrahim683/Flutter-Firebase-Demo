import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/auth/SignUpPage.dart';
import 'package:firebase_flutter/ui/homepage/HomePage.dart';
import 'package:firebase_flutter/util/UserNotifyUtil.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserNotifyUtil? userNotifyUtil;
  final GlobalKey _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  logInUser() async {
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      print("signInError: ${e.code}");
      userNotifyUtil!.showSnackBar(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    userNotifyUtil = UserNotifyUtil(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset('images/firebase.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Email Text Field
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // Password Text Field
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Login Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: ElevatedButton(
                      onPressed: () {
                        logInUser();
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // Sign Up Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 15.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

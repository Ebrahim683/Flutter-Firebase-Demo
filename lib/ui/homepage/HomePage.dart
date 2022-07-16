import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/ui/auth/LoginPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var name, email;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  setUserInfo() async {
    print("uid: ${user?.uid}");
    final ref = FirebaseDatabase.instance.ref('users').child(user!.uid);
    final nameEvent = await ref.child('name').once(DatabaseEventType.value);
    print('fName: $name');
    final emailEvent = await ref.child('email').once(DatabaseEventType.value);
    print('fEmail: $email');
    setState(() {
      name = nameEvent.snapshot.value ?? "null";
      email = emailEvent.snapshot.value ?? "null";
    });
  }

  logOut() async {
    await firebaseAuth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    setUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                logOut();
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: Container(
                height: 250,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 50.0,
                      child: Column(
                        children: [
                          Text(
                            name.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            email.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: -60.0,
                      right: 0.0,
                      left: 0.0,
                      child: SizedBox(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

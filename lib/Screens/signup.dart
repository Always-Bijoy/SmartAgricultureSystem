import 'package:flutter/material.dart';

import 'package:realtime_database/Service/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final FirebaseAuth auth;

  const SignUp({Key key, this.auth}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/signup2.jpg"), context);
    return Scaffold(
      backgroundColor: Color(0xffC0AE9D),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 29),
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/farmersignup.png",), fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Getting started',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Create account to continue!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Your Email",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: RaisedButton(
                        color: Color.fromRGBO(255, 79, 90, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _firebaseAuthService
                              .signup(emailController.text.trim(),
                                  passwordController.text.trim())
                              .then((UserCredential userCredential) {
                            if (userCredential != null) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (_) => false);
                            }
                          }).catchError((onError) => print(onError));
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(255, 79, 90, 1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "OPPS I ALREADY HAVE AN ACCOUNT",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(255, 79, 90, 1),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        }),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

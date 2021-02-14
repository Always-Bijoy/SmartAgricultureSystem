import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/Service/firebase_auth.dart';

import 'home.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuthService _user = FirebaseAuthService();

  User logUser;

  bool isAuth = false;

  void initState() {
    super.initState();

    logUser = _user.logedcurrentUser();
    if (logUser == null) {
      isAuth = false;
    } else {
      isAuth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/welcome2.png"), context);
    return isAuth
        ? Home()
        : Scaffold(
            backgroundColor: Color(0xffF7ECB4),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/welcome2.1.png'),
                        fit: BoxFit.fill
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Let\'s Get \nStarted',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Everything works better in together',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(186, 0, 216, 1),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(183, 0, 216, 1),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: RaisedButton(
                              color: Color.fromRGBO(59, 7, 127, 1),
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
                                Navigator.pushReplacementNamed(
                                    context, '/signup');
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/Service/firebase_auth.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final FirebaseAuthService _user = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/pic2.jpg"), context);

    return Scaffold(
      backgroundColor: Color(0xffDEEDEA),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(50),
                image: DecorationImage(
                    image: AssetImage("assets/farmerlogin.png"), fit: BoxFit.fill),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, top: 60),
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: ClipOval(
            //       child: Material(
            //         color: Colors.black12,
            //         child: InkWell(
            //           splashColor: Colors.black, // inkwell color
            //           child: SizedBox(
            //               width: 40,
            //               height: 40,
            //               child: Icon(
            //                 Icons.arrow_back_ios,
            //                 size: 12,
            //                 color: Colors.black38,
            //               )),
            //           onTap: () {
            //             Get.to(Welcome(), transition: Transition.rightToLeft);
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome Back!',
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
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter your credentials to continue',
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
                        color: Color.fromRGBO(1, 2, 252, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          UserCredential user =
                              await _user.loginUsernamePassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (user != null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (_) => false);
                          } else {
                            Navigator.pushNamed(context, '/login');
                          }
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
                              width: 1, color: Color.fromRGBO(1, 2, 252, 1)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "OPPS I DON'T HAVE ACCOUNT YET",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(1, 2, 252, 1)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        }),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

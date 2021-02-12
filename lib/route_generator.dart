import 'package:flutter/material.dart';

import 'Screens/home.dart';
import 'Screens/login.dart';
import 'Screens/signup.dart';
import 'Screens/welcome.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    String arg = settings.arguments;

      //  onPressed: () => Navigator.pushReplacementNamed(context, '/'),

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Welcome());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error Page'),
        ),
        body: Center(
          child: Text('error Page'),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uas/config/pallete.dart';
import 'Welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() async {
    var durasi = const Duration(seconds: 2);
    return Timer(durasi, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.local_hospital,
              size: 100.0,
              color: Colors.red,
            ),
            SizedBox(height: 24.0),
            Text("Covid-19",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            )
          ]
        ),
      ),
    );
  }
}

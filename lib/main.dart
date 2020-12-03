import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uas/screens/Contents/contents.dart';
import 'screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Program Info Covid-19',
      debugShowCheckedModeBanner: false,
      routes: {
        CallScreen.id: (context) => CallScreen(),
        MessageScreen.id: (context) => MessageScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

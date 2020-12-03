import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas/screens/Login/login_screen.dart';
import 'package:uas/screens/SignUp/components/background.dart';
import 'package:uas/screens/components/components.dart';
import 'package:uas/screens/components/imgurl.dart';
import 'package:uas/widgets/navbar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username, email, password;

  final auth = FirebaseAuth.instance;

  void check() async {
    try {
      final userSignUp = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userSignUp != null) {
        await FirebaseAuth.instance.currentUser
            .updateProfile(
              displayName: username,
              photoURL: noPic,
            );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Navbar(),
            ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/main.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                icon: Icons.person,
                hintText: "Username",
                onChanged: (value) {
                  username = value;
                },
              ),
              RoundedInputField(
                icon: Icons.email,
                hintText: "Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {
                  check();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

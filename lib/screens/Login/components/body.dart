import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas/screens/Login/components/background.dart';
import 'package:uas/screens/SignUp/SignUp.dart';
import 'package:uas/screens/components/components.dart';
import 'package:uas/widgets/widgets.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password;
  final auth = FirebaseAuth.instance;

  void check() async {
    try {
      final userSignIn = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userSignIn != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Navbar(),
          )
        );
      }
    } catch (e) {
      print("$e, $password");
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Gagal Login"), duration: Duration(seconds: 2)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/logincovid-19.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              icon: Icons.email,
              hintText: "Your Email",
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
              text: "LOGIN",
              press: () {
                check();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

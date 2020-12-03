import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/screens/Contents/contents.dart';
import 'package:uas/screens/Login/login_screen.dart';
import 'package:uas/screens/components/imgurl.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final auth = FirebaseAuth.instance;

  String picture = noPic;

  User loggedIn;

  void getLoggedIn() {
    final user = auth.currentUser;
    if (user != null) {
      loggedIn = user;

      if (loggedIn.photoURL != null) {
        picture = loggedIn.photoURL;
      }
    }
  }

  void initState() {
    super.initState();
    getLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Pallete.primaryColor,
      elevation: 1.0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Covid-19",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
          icon:
              CircleAvatar(backgroundImage: NetworkImage(picture), radius: 80),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile"),
                    Icon(Icons.person, color: Colors.black),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Log Out"),
                    Icon(Icons.exit_to_app, color: Colors.black),
                  ],
                ),
                value: 1,
              ),
            ];
          },
          onSelected: (select) {
            if (select == 1) {
              auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            }
          },
        )
      ],
    );
  }
}

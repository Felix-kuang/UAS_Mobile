import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/screens/components/imgurl.dart';
import 'package:uas/widgets/navbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  User loggedIn;
  File image;
  bool changed = false;
  String newName;
  String username = 'User';
  String picture = noPic;

  //variabel untuk bagian tanggal
  DateTime creation;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  Future<String> update() async {
    print(newName);
    if (newName != null) {
      await loggedIn.updateProfile(displayName: newName);
    }

    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child(loggedIn.uid);
      UploadTask uploadtask = ref.putFile(image);

      var downurl = await (await uploadtask).ref.getDownloadURL();
      var url = downurl.toString();

      await loggedIn.updateProfile(photoURL: url);
    }
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navbar(),
        ));
  }

  void getLoggedIn() {
    final user = auth.currentUser;
    if (user != null) {
      loggedIn = user;
      if (loggedIn.displayName != null) {
        username = loggedIn.displayName;
        creation = loggedIn.metadata.creationTime;
      }
      if (loggedIn.photoURL != null) {
        picture = loggedIn.photoURL;
      }
    }
  }

  Future getPic() async {
    var pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        changed = true;
      }
    });
  }

  void initState() {
    super.initState();
    getLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Profil",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Pallete.primaryColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navbar(),
                  ));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                update();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230.0,
            decoration: BoxDecoration(
                color: Pallete.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: CircleAvatar(
                      backgroundImage: image == null
                          ? NetworkImage(picture)
                          : FileImage(image),
                      radius: 80),
                  onTap: () {
                    getPic();
                  },
                ),
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: username,
                      hintStyle: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  onChanged: (value) {
                    newName = value;
                  },
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Center(
            child: Column(
              children: [
                Text(
                  "Bergabung Sejak:",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  formatter.format(creation),
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

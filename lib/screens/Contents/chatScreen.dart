import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/screens/components/imgurl.dart';
import 'package:uas/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  static const String id = "Chat_Screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  dynamic err;
  dynamic username = "User";
  User loggedIn;
  bool stat;
  String pesan = "";
  final auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  var picture = noPic;
  var _controller = TextEditingController();

  void getLoggedIn() {
    final user = auth.currentUser;
    if (user != null) {
      loggedIn = user;
      if (loggedIn.displayName != null) {
        username = loggedIn.displayName;
      }
    }
  }

  void initState() {
    super.initState();
    getLoggedIn();
    ChatScreen();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Pallete.primaryColor,
        appBar: CustomAppBar(),
        body: Container(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: firestoreInstance
                        .collection("Pesan")
                        .orderBy("Waktu", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView(
                            children: snapshot.data.docs.map((e) {
                          return Center(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.lightBlue[50]),
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(e['image']),
                                  radius: 30,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e["username"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          e["Pesan"],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        timeago.format(
                                            DateTime.tryParse(
                                                e["Waktu"].toDate().toString()),
                                            locale: "en_short"),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      e['UserID'] == loggedIn.uid
                                          ? RaisedButton(
                                              onPressed: () async {
                                                await firestoreInstance
                                                    .runTransaction(
                                                        (transaction) async {
                                                  transaction
                                                      .delete(e.reference);
                                                });
                                              },
                                              child: Text("Hapus"),
                                              color: Colors.red[100],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  side: BorderSide(
                                                      color: Colors.black)),
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                        }).toList());
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Card(
                    child: ListTile(
                        title: TextField(
                          controller:  _controller,
                          onChanged: (value) {
                            pesan = value;
                          },
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              //code here
                              _controller.clear();
                              await firestoreInstance
                                  .collection("Pesan")
                                  .doc()
                                  .set({
                                    "username": loggedIn.displayName,
                                    "UserID": loggedIn.uid,
                                    "Pesan": "$pesan",
                                    "Waktu": DateTime.now(),
                                    "image": loggedIn.photoURL,
                                  })
                                  .then((value) => print(""))
                                  .catchError(err);
                            })),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

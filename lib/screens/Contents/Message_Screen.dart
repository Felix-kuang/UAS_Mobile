import 'package:flutter/material.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/widgets/custom_appbar.dart';

class MessageScreen extends StatelessWidget {
  static const String id = "Message_Screen";

  final String imgProfile =
      "https://www.nicepng.com/png/full/87-874647_red-cross-hospital-logo-hospital-logo-red-cross.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230.0,
            decoration: BoxDecoration(
                color: Pallete.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imgProfile),
                  radius: 80.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Email: aplikasi.covid19@gmail.com",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "WhatsApp: 081234567890",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Merasa Terbantu?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton.icon(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    color: Colors.grey,
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    label: Text(""),
                  ),
                  RaisedButton.icon(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    color: Colors.grey,
                    icon: Icon(
                      Icons.thumb_down,
                      color: Colors.white,
                    ),
                    label: Text(""),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

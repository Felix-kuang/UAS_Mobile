import 'package:flutter/material.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/widgets/custom_appbar.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String nama = "Nama";
  String nim = "Nim";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tentang Kami",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          nama = "William Sebastian Thio";
                          nim = "32180006";
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://student.ubm.ac.id/images/foto/32180006.jpg"),
                        radius: 40,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          nama = "Jet J Krisnadi";
                          nim = "32180014";
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://student.ubm.ac.id/images/foto/32180014.jpg"),
                        radius: 40,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          nama = "Felix";
                          nim = "32180032";
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://student.ubm.ac.id/images/foto/32180032.jpg"),
                        radius: 40,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nim,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          )
        ]
      )
    );
  }
}

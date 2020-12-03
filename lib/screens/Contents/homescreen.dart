import 'package:flutter/material.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/data/data.dart';
import 'package:uas/widgets/widgets.dart';

import 'contents.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "Home_Screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildPrevention(screenHeight),
          _buildOwnTest(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Pallete.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Anda merasa tidak enak badan?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Jika anda merasa mengalami gejala Covid-19,\nHubungi kami untuk mendapatkan bantuan.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  onPressed: () {
                    Navigator.pushNamed(context, CallScreen.id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.red,
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Telepon",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RaisedButton.icon(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  onPressed: () {
                    Navigator.pushNamed(context, MessageScreen.id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.lightBlue[300],
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Kirim Pesan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPrevention(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pencegahan",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pencegahan
                    .map(
                      (e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.11,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            e.values.first,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100], Pallete.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: screenHeight * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/images/own_test.png"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lakukan Tes Sendiri",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Ikuti instruksi untuk \nmelakukan tes sendiri",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}

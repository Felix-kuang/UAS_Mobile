import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/config/pallete.dart';
import 'package:uas/config/styles.dart';
import 'package:uas/model/model.dart';
import 'package:uas/widgets/widgets.dart';

import 'contents.dart';

class StatistikScreen extends StatefulWidget {
  static const String id = "Statistik_Screen";
  static int regionId;
  static int hari;
  static String total, sembuh, meninggal, rawat;
  static String link, kasus;
  static bool cek;

  @override
  _StatistikScreenState createState() => _StatistikScreenState();
}

class _StatistikScreenState extends State<StatistikScreen> {
  Future<DataTotal> ambildata;
  List<double> grafik;

  Future dataCovid() async {
    if (StatistikScreen.regionId == 0) {
      if (StatistikScreen.hari == 0) {
        //Indo Total
        StatistikScreen.link =
            "https://disease.sh/v3/covid-19/countries/indonesia?strict=true";
        StatistikScreen.cek = true;
      } else if (StatistikScreen.hari == 1) {
        //Indo Hari ini
        StatistikScreen.link =
            "https://disease.sh/v3/covid-19/countries/indonesia?strict=true";
        StatistikScreen.cek = false;
      } else {
        //Indo Kemarin
        StatistikScreen.link =
            "https://disease.sh/v3/covid-19/countries/indonesia?yesterday=true&strict=true";
        StatistikScreen.cek = false;
      }
    } else {
      if (StatistikScreen.hari == 0) {
        //Global Total
        StatistikScreen.link = "https://disease.sh/v3/covid-19/all";
        StatistikScreen.cek = true;
      } else if (StatistikScreen.hari == 1) {
        //Global Hari ini
        StatistikScreen.link = "https://disease.sh/v3/covid-19/all";
        StatistikScreen.cek = false;
      } else {
        //Global Kemarin
        StatistikScreen.link =
            "https://disease.sh/v3/covid-19/all?yesterday=true";
        StatistikScreen.cek = false;
      }
    }
    ambildata = getData(StatistikScreen.link);
  }

  void initState() {
    super.initState();
    StatistikScreen.regionId = 0;
    StatistikScreen.hari = 0;
    dataCovid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.primaryColor,
        appBar: CustomAppBar(),
        body: FutureBuilder<DataTotal>(
          future: ambildata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (StatistikScreen.cek) {
                // jika true = data total
                StatistikScreen.total = NumberFormat.decimalPattern()
                    .format(snapshot.data.total)
                    .toString();
                StatistikScreen.meninggal = NumberFormat.decimalPattern()
                    .format(snapshot.data.meninggal)
                    .toString();
                StatistikScreen.sembuh = NumberFormat.decimalPattern()
                    .format(snapshot.data.sembuh)
                    .toString();
                StatistikScreen.rawat = NumberFormat.decimalPattern()
                    .format(snapshot.data.rawat)
                    .toString();
              } else {
                // jika false = data hari ini/kemarin
                StatistikScreen.total = NumberFormat.decimalPattern()
                    .format(snapshot.data.totalToday)
                    .toString();
                StatistikScreen.meninggal = NumberFormat.decimalPattern()
                    .format(snapshot.data.meninggalToday)
                    .toString();
                StatistikScreen.sembuh = NumberFormat.decimalPattern()
                    .format(snapshot.data.sembuhToday)
                    .toString();
                StatistikScreen.rawat = NumberFormat.decimalPattern()
                    .format(snapshot.data.rawatToday)
                    .toString();
              }
              return Column(children: [
                header(),
                tabHari(),
                negara(),
                stat(),
              ]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white.withAlpha(80),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
            color: Pallete.primaryColor,
            child: GestureDetector(
              onVerticalDragStart: (details) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: (context) => ChatScreen());
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_upward),
                    Text(
                      "Chat",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
              ),
            )));
  }

  Widget negara() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(25.0)),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 50.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [Text("Indonesia"), Text("Global")],
            onTap: (index) {
              setState(() {
                StatistikScreen.regionId = index;
                dataCovid();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Statistik",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget tabHari() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DefaultTabController(
        length: 3,
        child: Container(
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Text("Total"),
              Text("Hari ini"),
              Text("Kemarin"),
            ],
            onTap: (index) {
              setState(() {
                StatistikScreen.hari = index;
                dataCovid();
              });
            },
          ),
        ),
      ),
    );
  }
}

Widget stat() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: StatsCard(
      total: StatistikScreen.total,
      meninggal: StatistikScreen.meninggal,
      sembuh: StatistikScreen.sembuh,
      rawat: StatistikScreen.rawat,
    ),
  );
}

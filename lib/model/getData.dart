import 'dart:convert';
import 'package:http/http.dart' as http;

class DataTotal {
  final int total;
  final int meninggal;
  final int sembuh;
  final int rawat;
  final int totalToday;
  final int meninggalToday;
  final int sembuhToday;
  final int rawatToday;

  DataTotal(
      {this.total,
      this.meninggal,
      this.sembuh,
      this.rawat,
      this.totalToday,
      this.meninggalToday,
      this.sembuhToday,
      this.rawatToday});

  factory DataTotal.fromJson(Map<String, dynamic> json) {
    return DataTotal(
      total: json["cases"],
      meninggal: json["deaths"],
      sembuh: json["recovered"],
      rawat: json["active"],
      totalToday: json["todayCases"],
      meninggalToday: json["todayDeaths"],
      sembuhToday: json["todayRecovered"],
      rawatToday: json["active"],
    );
  }
}

Future<DataTotal> getData(String link) async {
  final response = await http.get(link);

  if (response.statusCode == 200) {
    return DataTotal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Gagal Load data");
  }
}


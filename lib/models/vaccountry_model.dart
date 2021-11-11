import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<VacCountrywise> vacCountrywiseFromJson(String str) =>
    List<VacCountrywise>.from(
        json.decode(str).map((x) => VacCountrywise.fromJson(x)));

class VacCountrywise {
  VacCountrywise({
    required this.country,
    required this.timeline,
  });

  String country;
  Map<String, int> timeline;

  factory VacCountrywise.fromJson(Map<String, dynamic> json) => VacCountrywise(
        country: json["country"],
        timeline: Map.from(json["timeline"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );
}

class VacCountry extends StatefulWidget {
  const VacCountry({Key? key}) : super(key: key);

  @override
  State<VacCountry> createState() => _VacCountryState();
}

class _VacCountryState extends State<VacCountry> {
  VacCountrywise vacCountrywise = VacCountrywise(country: '', timeline: {});

  fetchVacCountryData() async {
    http.Response response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/vaccine/coverage/countries?lastdays=1'));
    var res = jsonDecode(response.body);
    setState(() {
      print(res);
      var vacCountrywise = vacCountrywiseFromJson(res);
      print(vacCountrywise);
    });
  }

  @override
  void initState() {
    fetchVacCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}

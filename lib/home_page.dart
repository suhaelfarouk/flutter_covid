import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';
import 'package:flutter_covid/pages/offline_page.dart';

import 'package:flutter_covid/panels/chart_panel.dart';

import 'package:flutter_covid/panels/navbar_panel.dart';
import 'package:flutter_covid/panels/vaccine_panel.dart';
import 'package:flutter_covid/panels/worldwide_panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final quote = DataSource.quote;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? worldData;
  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  List? countryData;
  fetchAffectedCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://disease.sh/v3/covid-19/countries?sort=deaths'));
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  Map? casesData;
  List<double>? cases;
  fetchCasesData() async {
    http.Response response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/historical/all?lastdays=all'));
    setState(() {
      casesData = jsonDecode(response.body)['cases'];
    });

    List<double> cas = [];

    for (final name in casesData!.keys) {
      final value = casesData![name];
      cas.add(value.toDouble());
    }
    int thirty = cas.length - 30;
    cas.removeRange(0, thirty);

    List<double> secondCase = [];
    Map map = cas.asMap();

    for (var i = 0; i < (cas.length - 1); i++) {
      secondCase.add((map[i + 1] - map[i]));
    }
    cases = secondCase;
  }

  Map? deathsData;
  List<double>? deaths;
  fetchDeathsData() async {
    http.Response response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/historical/all?lastdays=all'));
    setState(() {
      deathsData = jsonDecode(response.body)['deaths'];
    });

    List<double> dea = [];
    for (final name in deathsData!.keys) {
      final value = deathsData![name];
      dea.add(value.toDouble());
    }
    int thirty = dea.length - 30;
    dea.removeRange(0, thirty);

    List<double> secondDeath = [];
    Map map = dea.asMap();

    for (var i = 0; i < (dea.length - 1); i++) {
      secondDeath.add((map[i + 1] - map[i]));
    }

    deaths = secondDeath;
  }

  Map? recoveredData;
  List<double>? recovered;
  fetchRecoveredData() async {
    http.Response response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/historical/all?lastdays=all'));
    setState(() {
      recoveredData = jsonDecode(response.body)['recovered'];
    });

    List<double> rec = [];
    for (final name in recoveredData!.keys) {
      final value = recoveredData![name];
      rec.add(value.toDouble());

      rec.removeWhere((element) => element < 1);
    }
    int thirty = rec.length - 30;
    rec.removeRange(0, thirty);

    List<double> secondRecovered = [];
    Map map = rec.asMap();

    for (var i = 0; i < (rec.length - 1); i++) {
      secondRecovered.add((map[i + 1] - map[i]));
    }

    recovered = secondRecovered;
  }

  Map? vaccineData;
  List<double>? vaccine;
  double? lastVaccine;
  double? todayVaccine;

  fetchVaccineData() async {
    http.Response response = await http.get(Uri.parse(
        'https://disease.sh/v3/covid-19/vaccine/coverage?lastdays=195&fullData=false'));
    setState(() {
      vaccineData = jsonDecode(response.body);
    });

    List<double> vac = [];

    for (final name in vaccineData!.keys) {
      final value = vaccineData![name];
      vac.add(value.toDouble());
    }
    lastVaccine = vac.last;

    int thirty = vac.length - 30;
    vac.removeRange(0, thirty);

    List<double> secondVaccine = [];
    Map map = vac.asMap();

    for (var i = 0; i < (vac.length - 1); i++) {
      secondVaccine.add((map[i + 1] - map[i]));
      secondVaccine.removeWhere((element) => element <= 1);
    }
    todayVaccine = secondVaccine.last;

    vaccine = secondVaccine;
  }

  Future<void> refreshUI() async {
    Navigator.pop(context);
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBar()));
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchAffectedCountryData();
    fetchCasesData();
    fetchDeathsData();
    fetchRecoveredData();
    fetchVaccineData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black45
          : Colors.black12,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            onPressed: () =>
                EasyDynamicTheme.of(context).themeMode == ThemeMode.light
                    ? EasyDynamicTheme.of(context).changeTheme(dark: true)
                    : EasyDynamicTheme.of(context).changeTheme(dark: false),
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight,
            ),
          )
        ],
        centerTitle: false,
        title: Text(
          'Worldwide Statistics',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.grey[800],
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
      ),
      body: SafeArea(
        child: lastVaccine == null ||
                vaccine == null ||
                worldData == null ||
                todayVaccine == null ||
                deaths == null ||
                recovered == null ||
                cases == null
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: SpinKitThreeBounce(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primaryBlack,
                  size: 27,
                ),
              )
            : RefreshIndicator(
                onRefresh: refreshUI,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DelayedDisplay(
                        delay: Duration(milliseconds: 700),
                        child: VaccinePanel(
                          lastVaccine: lastVaccine,
                          vaccine: vaccine,
                          todayVaccine: todayVaccine,
                        ),
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: 1200),
                        child: WorldWidePanel(
                          worldData: worldData,
                        ),
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: 1500),
                        child: ChartPanel(
                          recovered: recovered,
                          cases: cases,
                          deaths: deaths,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

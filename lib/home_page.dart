import 'dart:convert';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';
import 'package:flutter_covid/models/chart_api.dart';
import 'package:flutter_covid/pages/vaccine_page.dart';
import 'package:flutter_covid/panels/chart_panel.dart';
import 'package:flutter_covid/panels/info_panel.dart';
import 'package:flutter_covid/panels/mostaffected_panel.dart';
import 'package:flutter_covid/panels/navbar_panel.dart';
import 'package:flutter_covid/panels/vaccine_panel.dart';
import 'package:flutter_covid/panels/worldwide_panel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'models/chart_model.dart';

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
      //cas.removeWhere((element) => element <= 195800000);
    }
    int thirty = cas.length - 30;
    cas.removeRange(0, thirty);

    List<double> secondCase = [];
    Map map = cas.asMap();

    for (var i = 0; i < (cas.length - 1); i++) {
      secondCase.add((map[i + 1] - map[i]));
    }
    //print(secondCase);
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

      // dea.removeWhere((element) => element <= 4190000);
      //print('$value');
      // return val;
      //deaths = dea; // prints entries like "AED,3.672940"
    }
    int thirty = dea.length - 30;
    dea.removeRange(0, thirty);

    List<double> secondDeath = [];
    Map map = dea.asMap();

    for (var i = 0; i < (dea.length - 1); i++) {
      secondDeath.add((map[i + 1] - map[i]));
    }
    // print(secondDeath);
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
      //recovered = rec;
    }
    int thirty = rec.length - 30;
    rec.removeRange(0, thirty);

    List<double> secondRecovered = [];
    Map map = rec.asMap();

    for (var i = 0; i < (rec.length - 1); i++) {
      secondRecovered.add((map[i + 1] - map[i]));
    }
    //print(secondRecovered);
    recovered = secondRecovered;
  }

  Map? vaccineData;
  List<double>? vaccine;
  double? lastVaccine;
  double? todayVaccine;
  // var sumVaccine;
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
      //vaccine = vac;
    }
    lastVaccine = vac.last;

    int thirty = vac.length - 30;
    vac.removeRange(0, thirty);
    //vac.removeWhere((element) => element <= 4000000000);

    List<double> secondVaccine = [];
    Map map = vac.asMap();

    for (var i = 0; i < (vac.length - 1); i++) {
      secondVaccine.add((map[i + 1] - map[i]));
      secondVaccine.removeWhere((element) => element <= 1);
    }
    todayVaccine = secondVaccine.last;
    //print(secondVaccine);
    vaccine = secondVaccine;

    //print(todayVaccine);
  }

  Future<void> refreshUI() async {
    Navigator.pop(context);
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBar()));
    });
  }

  // Map? vaccineTodayData;
  // // List<double> vaccineToday = [];
  // var vaccineToday;
  // fetchVaccineTodayData() async {
  //   http.Response response = await http.get(Uri.parse(
  //       'https://disease.sh/v3/covid-19/vaccine/coverage?lastdays=1&fullData=false'));
  //   setState(() {
  //     vaccineTodayData = jsonDecode(response.body);
  //   });
  //   List vacci = [];

  //   for (final name in vaccineTodayData!.keys) {
  //     final value = vaccineTodayData![name];
  //     vacci.add(value);
  //     vaccineToday = vacci[0];
  //   }
  //   print(vaccineToday);
  // }

  //List<ChartApiModel>? chart;

  // List<charts.Series<TimeSeriesCases, DateTime>> seriesList = [];
  // bool? animate;
  // List<CountrySummaryModel> summaryList = [];

  // Future<List<CountrySummaryModel>> getCountrySummary() async {
  //   final data = await http.Client()
  //       .get(Uri.parse('https://disease.sh/v3/covid-19/all'));

  //   if (data.statusCode != 200) throw Exception();

  //   List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
  //       .map((item) => new CountrySummaryModel.fromJson(item))
  //       .toList();

  //   return summaryList;
  // }

  // List? indianData;
  // fetchIndianData() async {
  //   http.Response response =
  //       await http.get(Uri.parse('https://disease.sh/v3/covid-19/gov/india'));
  //   setState(() {
  //     indianData = jsonDecode(response.body)['states'];
  //   });
  // }

  Future fetchData() async {
    fetchWorldWideData();
    fetchAffectedCountryData();
    // getCountrySummary();
    //loadChartData();
    fetchCasesData();
    fetchDeathsData();
    fetchRecoveredData();
    fetchVaccineData();
    //fetchNewsData();
    // refreshUI();
    //fetchVaccineTodayData();
    // fetchChartData();
    // fetchSparkline();
    // fetchIndianData();
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
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.lightbulb_outline
                : Icons.highlight),
          )
        ],
        centerTitle: false,
        title: Text(
          'Worldwide Coronavirus Statistics',
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
                  //duration: Duration(seconds: 4),
                ),
              )
            : RefreshIndicator(
                onRefresh: refreshUI,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: //worldData == null&&

                      Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //InfoPanel(),

                      DelayedDisplay(
                        delay: Duration(milliseconds: 700),
                        child:
                            // lastVaccine == null &&
                            //         vaccine == null &&
                            //         todayVaccine == null
                            //     ? Container(
                            //         color: Colors.transparent,
                            //       )
                            //     :
                            VaccinePanel(
                          lastVaccine: lastVaccine,
                          vaccine: vaccine,
                          todayVaccine: todayVaccine,
                        ),
                      ),
                      // DelayedDisplay(
                      //   delay: Duration(milliseconds: 500),
                      //   child: Divider(),
                      // ),

                      DelayedDisplay(
                        delay: Duration(milliseconds: 1200),
                        child:
                            // worldData == null
                            //     ? Container(
                            //         color: Colors.transparent,
                            //       )
                            //     :
                            WorldWidePanel(
                          worldData: worldData,
                        ),
                      ),
                      // DelayedDisplay(
                      //     delay: Duration(milliseconds: 1000),
                      //     child: Divider()),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.only(bottom: 0, left: 20, right: 20),
                          height: 154,
                          //width: 160,
                          // width: 150,
                          decoration: BoxDecoration(
                            color:
                                // Theme.of(context).brightness ==
                                //         Brightness.dark
                                //     ? primaryBlack
                                //     :
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 1700),
                            child:
                                //  recovered == null &&
                                //         cases == null &&
                                //         deaths == null
                                //     ? Container(
                                //         color: Colors.transparent,
                                //       )
                                //     :
                                ChartPanel(
                                    recovered: recovered,
                                    cases: cases,
                                    deaths: deaths),
                          )
                          // Stack(
                          //   //clipBehavior: Clip.hardEdge,
                          //   alignment: Alignment.center,
                          //   //fit: StackFit.loose,
                          //   children: [
                          //     Sparkline(
                          //       data: recovered,
                          //       useCubicSmoothing: true,
                          //       cubicSmoothingFactor: 0.1,
                          //       lineWidth: 3,
                          //       lineColor: Colors.green,
                          //       fillMode: FillMode.below,
                          //       fillGradient: LinearGradient(
                          //         begin: Alignment.topCenter,
                          //         end: Alignment.bottomCenter,
                          //         colors: [
                          //           Theme.of(context).brightness ==
                          //                   Brightness.dark
                          //               ? Colors.green[900]!
                          //               : Colors.green[300]!,
                          //           Theme.of(context).brightness ==
                          //                   Brightness.dark
                          //               ? Colors.black
                          //               : Colors.white,
                          //         ],
                          //       ),

                          //       // fillColor: Colors.black,
                          //       // enableThreshold: true,
                          //       // thresholdSize: 0.5,
                          //       // kLine: ['last'],
                          //       // enableGridLines: true,
                          //       // gridLineLabelColor: primaryBlack,
                          //       // gridLineAmount: 2,
                          //       // gridLineColor: primaryBlack,
                          //       max: 600000.0,
                          //       min: 1.0,
                          //     ),

                          //     Sparkline(
                          //       data: cases,
                          //       useCubicSmoothing: true,
                          //       cubicSmoothingFactor: 0.1,
                          //       lineWidth: 3,
                          //       lineColor: Colors.blue[900]!,
                          //       fillGradient: LinearGradient(
                          //         begin: Alignment.topCenter,
                          //         end: Alignment.bottomCenter,
                          //         colors: [
                          //           Theme.of(context).brightness ==
                          //                   Brightness.dark
                          //               ? Colors.blue[900]!
                          //               : Colors.blue[300]!,
                          //           Theme.of(context).brightness ==
                          //                   Brightness.dark
                          //               ? Colors.black
                          //               : Colors.white,
                          //         ],
                          //       ),
                          //       fillMode: FillMode.below,

                          //       // fillColor: Colors.red,
                          //       // enableThreshold: true,
                          //       // thresholdSize: 0.5,
                          //       //kLine: ['last'],
                          //       //enableGridLines: true,
                          //       // gridLineLabelColor: primaryBlack,
                          //       // gridLineAmount: 2,
                          //       // gridLineColor: primaryBlack,
                          //       max: 1200000.0,
                          //       min: 1.0,
                          //       // pointsMode: PointsMode.last,
                          //     ),
                          //     Sparkline(
                          //       data: deaths,
                          //       useCubicSmoothing: true,
                          //       cubicSmoothingFactor: 0.1,
                          //       lineWidth: 3,
                          //       lineColor: Theme.of(context).brightness ==
                          //               Brightness.dark
                          //           ? Colors.grey[400]!
                          //           : Colors.grey[900]!,
                          //       //fillMode: FillMode.below,
                          //       // fillGradient: LinearGradient(
                          //       //   begin: Alignment.topCenter,
                          //       //   end: Alignment.bottomCenter,
                          //       //   colors: [Colors.grey[900]!, Colors.white],
                          //       // ),
                          //       // enableThreshold: true,
                          //       // thresholdSize: 0.5,
                          //       // kLine: ['last'],
                          //       // enableGridLines: true,
                          //       // gridLineLabelColor: primaryBlack,
                          //       // gridLineAmount: 2,
                          //       // gridLineColor: primaryBlack,
                          //       max: 120000.0,
                          //       min: 1.0,
                          //     ),

                          //     // Container(
                          //     //   height: 170,
                          //     //   decoration: BoxDecoration(
                          //     //     color: Colors.orange[100],
                          //     //     borderRadius: BorderRadius.all(Radius.circular(8)),
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),

                          ),
                      //Divider(),
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: Container(
                      //     padding: EdgeInsets.all(15),
                      //     margin: EdgeInsets.all(15),
                      //     color: Colors.blue[100],
                      //     //color: Colors.black12,
                      //     height: 90,
                      //     width: 250,
                      //     child: Sparkline(
                      //       data: vaccine,
                      //       fillMode: FillMode.below,
                      //       //max: 22220000000.0,
                      //       fillGradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //         colors: [Colors.blue[800]!, Colors.blue[200]!],
                      //       ),
                      //       //fillColor: Colors.black12,
                      //     ),
                      //   ),
                      // ),
                      // worldData == null
                      //     ? SizedBox(
                      //         height: MediaQuery.of(context).size.height / 1.3,
                      //         child: SpinKitThreeBounce(
                      //           color: Theme.of(context).brightness == Brightness.dark
                      //               ? Colors.white
                      //               : primaryBlack,
                      //           size: 27,
                      //           duration: Duration(seconds: 3),
                      //         ),
                      //       )
                      //     : Padding(
                      //         padding: const EdgeInsets.only(
                      //             right: 15, left: 15, bottom: 5, top: 5),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'Statistics',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 25,
                      //               ),
                      //             ),
                      //             IconButton(
                      //               color:
                      //                   Theme.of(context).brightness == Brightness.dark
                      //                       ? Colors.white
                      //                       : primaryBlack,
                      //               onPressed: () =>
                      //                   EasyDynamicTheme.of(context).themeMode ==
                      //                           ThemeMode.light
                      //                       ? EasyDynamicTheme.of(context)
                      //                           .changeTheme(dark: true)
                      //                       : EasyDynamicTheme.of(context)
                      //                           .changeTheme(dark: false),
                      //               icon: Icon(
                      //                   Theme.of(context).brightness == Brightness.light
                      //                       ? Icons.lightbulb_outline
                      //                       : Icons.highlight),
                      //             ),
                      //             // GestureDetector(
                      //             //   onTap: () {
                      //             //     Navigator.push(
                      //             //         context,
                      //             //         MaterialPageRoute(
                      //             //             builder: (context) => CountryPage()));
                      //             //   },
                      //             //   child: Container(
                      //             //     padding: EdgeInsets.all(10),
                      //             //     decoration: BoxDecoration(
                      //             //       color: primaryBlack,
                      //             //       borderRadius: BorderRadius.circular(20),
                      //             //     ),
                      //             //     child: Text(
                      //             //       'Regional',
                      //             //       style: TextStyle(
                      //             //         fontWeight: FontWeight.bold,
                      //             //         fontSize: 14,
                      //             //         color: Colors.white,
                      //             //       ),
                      //             //     ),
                      //             //   ),
                      //             // ),
                      //           ],
                      //         ),
                      //       ),
                      // // ChartPanel(value: value),

                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(8)),
                      //       color: Colors.orange[100],
                      //     ),
                      //     padding: EdgeInsets.only(right: 23, left: 23),
                      //     height: 90,
                      //     alignment: Alignment.center,
                      //     //color: Colors.orange[100],
                      //     child: Text(
                      //       DataSource.quote,
                      //       style: TextStyle(
                      //         color: Colors.orange[800],
                      //         fontWeight: FontWeight.w900,
                      //         fontSize: 16,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // countryData == null
                      //     ? Container()
                      //     : Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 15.0, vertical: 10.0),
                      //         child: Text(
                      //           'Deceased',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 20,
                      //           ),
                      //         ),
                      //       ),
                      // countryData == null
                      //     ? Container()
                      //     : MostAffectedPanel(
                      //         countryData: countryData,
                      //       ),
                      // InfoPanel(),

                      // SizedBox(
                      //   height: 10,
                      // ),

                      // summaryList == null
                      //     ? Icon(Icons.ac_unit)
                      //     : Container(
                      //         height: 10,
                      //         width: 20,
                      //         child: ChartPanel(
                      //             seriesList: seriesList,
                      //             animate: true,
                      //             summaryList: summaryList),
                      //       )
                      //Divider(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

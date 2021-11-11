// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_covid/models/chart_model.dart';
// import 'package:http/http.dart' as http;

// //Map? chartData;
// //List<ChartApiModel> chart = [];
// fetchChartData() async {
//   http.Response response = await http.get(
//       Uri.parse('https://covid.ourworldindata.org/data/owid-covid-data.json'));
//   var chartData = jsonDecode(response.body);
//   List hello = [];
//   chartData.forEach((key, value) {
//     if (key != "countryID") {
//       // print('This is key : $key');
//       // print('This is the value : $value');
//       // Following are the specific object value:

//       value.forEach((key, value) {
//         if (key == "data") {
//           // print('$key');
//           // print('$value');

//           // value.forEach((key, value) {
//           //   if (key != "hello") {
//           //     print('$key');
//           //print('$value');
//           hello = value.toList;
//           //   }
//           // });
//         }
//       });
//     }
//   });
//   print(hello);
// }



  // for (Map<String, dynamic> i in chartData) {
  //   chart.add(ChartApiModel.fromJson(i));
  // }

  // List<dynamic> cha = [];
  // for (final name in chartData!.keys) {
  //   final value = chartData![name];
  //   cha.add(value['data'][0]['new_cases']);
  //   //cha.add(value['data'][0]['new_cases']);
  //   chart = cha.whereType<double>().toList();
  // }
  // print(cha);
  // List<dynamic> chartList = cha;
  

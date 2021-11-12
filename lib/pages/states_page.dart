import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StatesPage extends StatefulWidget {
  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage> {
  List? statesData;
  fetchStatesData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/gov/india'));
    setState(() {
      statesData = jsonDecode(response.body)['states'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStatesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).brightness == Brightness.dark
      //       ? primaryBlack
      //       : Colors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           showSearch(context: context, delegate: Search(statesData!));
      //         },
      //         icon: Icon(Icons.search))
      //   ],
      //   title: Text(
      //     'States',
      //     style: TextStyle(
      //       color: Theme.of(context).brightness == Brightness.dark
      //           ? Colors.white
      //           : Colors.grey[800],
      //     ),
      //   ),
      // ),
      body: statesData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              //  height: 100,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 1),
                              child: Row(
                                children: [
                                  // CircleAvatar(
                                  //   backgroundImage: NetworkImage(
                                  //     countryData![index]['countryInfo']['flag'],
                                  //   ),
                                  //   radius: 10,
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      statesData![index]['state'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  //    SizedBox(height: 14),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 54,
                                      child: Text(
                                        // 'ACTIVE : ' +
                                        //  countryData![index]['active'].toString(),
                                        NumberFormat.compact()
                                            .format(
                                                statesData![index]['active'])
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 54,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // 'CONFIRMED : ' +
                                            //  countryData![index]['cases'].toString(),
                                            NumberFormat.compact()
                                                .format(
                                                    statesData![index]['cases'])
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            // 'CONFIRMED : ' +
                                            //  countryData![index]['cases'].toString(),
                                            ('+' +
                                                '${(NumberFormat.compact().format(statesData![index]['todayCases']).toString())}'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //  SizedBox(width: 10),
                                    Container(
                                      width: 54,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            //  'RECOVERED : ' +
                                            // countryData![index]['recovered'].toString(),
                                            NumberFormat.compact()
                                                .format(statesData![index]
                                                    ['recovered'])
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text(
                                            // 'CONFIRMED : ' +
                                            //  countryData![index]['cases'].toString(),
                                            ('+' +
                                                '${(NumberFormat.compact().format(statesData![index]['todayRecovered']).toString())}'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.green,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //  SizedBox(width: 10),

                                    //    SizedBox(width: 10),
                                    Container(
                                      width: 54,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            //  'DEATHS : ' +
                                            // countryData![index]['deaths'].toString(),
                                            NumberFormat.compact()
                                                .format(statesData![index]
                                                    ['deaths'])
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey[350]
                                                  : Colors.grey[900],
                                            ),
                                          ),
                                          Text(
                                            // 'CONFIRMED : ' +
                                            //  countryData![index]['cases'].toString(),
                                            ('+' +
                                                '${(NumberFormat.compact().format(statesData![index]['todayDeaths']).toString())}'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey[350]
                                                  : Colors.grey[900],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
              itemCount: statesData == null ? 0 : statesData!.length,
            ),
    );
  }
}

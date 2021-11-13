import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List? countryData;
  fetchAffectedCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://disease.sh/v3/covid-19/countries?sort=active'));
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAffectedCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black45
          : Colors.black12,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).brightness == Brightness.dark
      //       ? primaryBlack
      //       : Colors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           showSearch(context: context, delegate: Search(countryData!));
      //         },
      //         icon: Icon(Icons.search))
      //   ],
      //   title: Text(
      //     'Countries',
      //     style: TextStyle(
      //       color: Theme.of(context).brightness == Brightness.dark
      //           ? Colors.white
      //           : Colors.grey[800],
      //     ),
      //   ),
      // ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 114,
                                    //  height: 100,

                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            countryData![index]['countryInfo']
                                                ['flag'],
                                          ),
                                          radius: 9,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            countryData![index]['country'],
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
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        // mainAxisAlignment:
                                        //  MainAxisAlignment.start,
                                        // crossAxisAlignment:
                                        //  CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 54,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  // 'ACTIVE : ' +
                                                  //  countryData![index]['active'].toString(),
                                                  NumberFormat.compact()
                                                      .format(
                                                          countryData![index]
                                                              ['active'])
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 54,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  // 'CONFIRMED : ' +
                                                  //  countryData![index]['cases'].toString(),
                                                  NumberFormat.compact()
                                                      .format(
                                                          countryData![index]
                                                              ['cases'])
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                  //width: 12,
                                                ),
                                                Text(
                                                  // 'CONFIRMED : ' +
                                                  //  countryData![index]['cases'].toString(),
                                                  '+' +
                                                      '${(NumberFormat.compact().format(countryData![index]['todayCases']).toString())}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  //  'RECOVERED : ' +
                                                  // countryData![index]['recovered'].toString(),
                                                  NumberFormat.compact()
                                                      .format(
                                                          countryData![index]
                                                              ['recovered'])
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 14,
                                                  //width: 12,
                                                ),
                                                Text(
                                                  // 'CONFIRMED : ' +
                                                  //  countryData![index]['cases'].toString(),
                                                  '+' +
                                                      '${(NumberFormat.compact().format(countryData![index]['todayRecovered']).toString())}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  //  'DEATHS : ' +
                                                  // countryData![index]['deaths'].toString(),
                                                  NumberFormat.compact()
                                                      .format(
                                                          countryData![index]
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
                                                SizedBox(
                                                  height: 14,
                                                  //width: 12,
                                                ),
                                                Text(
                                                  // 'CONFIRMED : ' +
                                                  //  countryData![index]['cases'].toString(),
                                                  '+' +
                                                      '${(NumberFormat.compact().format(countryData![index]['todayDeaths']).toString())}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                            ],
                          ),
                        ),
                      ),
                      // Divider(),
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData!.length,
            ),
    );
  }
}

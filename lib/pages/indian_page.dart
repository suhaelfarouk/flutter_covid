import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class IndianPage extends StatefulWidget {
  @override
  _IndianPageState createState() => _IndianPageState();
}

class _IndianPageState extends State<IndianPage> {
  List? indianData;
  fetchIndianData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/gov/india'));
    setState(() {
      indianData = jsonDecode(response.body)['states'];
    });
  }

  @override
  void initState() {
    fetchIndianData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //     onPressed: () {
          //       showSearch(context: context, delegate: Search(indianData!));
          //     },
          //     icon: Icon(Icons.search))
        ],
        title: Text('Country Stats'),
      ),
      body: indianData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 130,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              indianData![index]['state'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 14),
                            // Image.network(
                            //   indianData![index]['deceased'],
                            //   height: 40,
                            //   width: 65,
                            //   fit: BoxFit.fill,
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'CONFIRMED : ' +
                                    indianData![index]['cases'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'RECOVERED : ' +
                                    indianData![index]['recovered'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'ACTIVE : ' +
                                    indianData![index]['active'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'DEATHS : ' +
                                    indianData![index]['deaths'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey[100]
                                      : Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: indianData == null ? 0 : indianData!.length,
            ),
    );
  }
}

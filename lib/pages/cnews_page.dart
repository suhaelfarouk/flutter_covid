import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class CnewsPage extends StatefulWidget {
  @override
  _CnewsPageState createState() => _CnewsPageState();
}

class _CnewsPageState extends State<CnewsPage>
    with AutomaticKeepAliveClientMixin {
  List? newsData;
  fetchNewsData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://google-search3.p.rapidapi.com/api/v1/news/q=kashmir+covid+news'),
      headers: {
        'x-rapidapi-host': 'google-search3.p.rapidapi.com',
        'x-rapidapi-key': '370a8fc18bmsh860ef3c4c5a4110p12a851jsn6fb5ac339fd1'
      },
    );
    if (mounted) {
      setState(() {
        newsData = jsonDecode(response.body)['entries'];
      });
    }

    // print(newsData);
  }

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black45
          : Colors.black12,
      body: newsData == null
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
                          top: 10.0,
                          right: 10.0,
                          left: 10.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SafeArea(
                                  child: WebviewScaffold(
                                    url: newsData![index]['link'],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   child: Image.network(
                                  //     newsData![index]['media'] == null
                                  //         ? 'https://icon-library.com/images/not-found-icon/not-found-icon-28.jpg'
                                  //         : newsData![index]['media'],
                                  //     width: 80,
                                  //     height: 80,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 15,
                                  // ),
                                  Expanded(
                                    child: Text(
                                      newsData![index]['title'],
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          newsData![index]['published'],
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          newsData![index]['source']['title'],
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Divider(),
                    ],
                  ),
                );
              },
              itemCount: 25),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

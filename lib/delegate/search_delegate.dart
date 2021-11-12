import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends SearchDelegate {
  final List countryList;
  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        //  height: 100,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                suggestionList[index]['countryInfo']['flag'],
                              ),
                              radius: 9,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                suggestionList[index]['country'],
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
                                  // 'CONFIRMED : ' +
                                  //  countryData![index]['cases'].toString(),
                                  NumberFormat.compact()
                                      .format(suggestionList[index]['cases'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              //  SizedBox(width: 10),
                              Container(
                                width: 54,
                                child: Text(
                                  //  'RECOVERED : ' +
                                  // countryData![index]['recovered'].toString(),
                                  NumberFormat.compact()
                                      .format(
                                          suggestionList[index]['recovered'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              //  SizedBox(width: 10),
                              Container(
                                width: 54,
                                child: Text(
                                  // 'ACTIVE : ' +
                                  //  countryData![index]['active'].toString(),
                                  NumberFormat.compact()
                                      .format(suggestionList[index]['active'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              //    SizedBox(width: 10),
                              Container(
                                width: 54,
                                child: Text(
                                  //  'DEATHS : ' +
                                  // countryData![index]['deaths'].toString(),
                                  NumberFormat.compact()
                                      .format(suggestionList[index]['deaths'])
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[100]
                                        : Colors.grey[900],
                                  ),
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
            ));
      },
      itemCount: suggestionList.length,
    );
  }
}

// ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             height: 130,
//             child: Row(
//               children: [
//                 Container(
//                   width: 150,
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         suggestionList[index]['country'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(height: 14),
//                       Image.network(
//                         suggestionList[index]['countryInfo']['flag'],
//                         height: 40,
//                         width: 65,
//                         fit: BoxFit.fill,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           'CONFIRMED : ' +
//                               suggestionList[index]['cases'].toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.red,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'RECOVERED : ' +
//                               suggestionList[index]['recovered'].toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.green,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'ACTIVE : ' +
//                               suggestionList[index]['active'].toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'DEATHS : ' +
//                               suggestionList[index]['deaths'].toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color:
//                                 Theme.of(context).brightness == Brightness.dark
//                                     ? Colors.grey[100]
//                                     : Colors.grey[900],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         })




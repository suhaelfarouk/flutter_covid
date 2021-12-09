// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Search extends SearchDelegate {
//   final List countryList;
//   Search(this.countryList);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: Icon(Icons.arrow_back_ios),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? countryList
//         : countryList
//             .where((element) =>
//                 element['country'].toString().toLowerCase().startsWith(query))
//             .toList();
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         return Container();
//       },
//       itemCount: suggestionList.length,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_covid/pages/faqs_page.dart';

// import 'package:url_launcher/url_launcher.dart';

// class InfoPanel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15, bottom: 15, right: 0, left: 0),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   color: Colors.green[100]),
//               child: GestureDetector(
//                 onTap: () {
//                   launch(
//                       'https://www.rusard.org/cause/kashmir-covid-19-relief/');
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
//                   //  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   //  color: primaryBlack,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.account_balance_wallet_outlined,
//                         //color: Colors.green,
//                         size: 38,
//                       ),
//                       Text(
//                         'HELP',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 11),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   color: Colors.blue[100]),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => FaqsPage()));
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
//                   //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   //color: primaryBlack,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.info_outlined,
//                         color: Colors.blue[900],
//                         size: 38,
//                       ),
//                       Text(
//                         'FAQS',
//                         style: TextStyle(
//                             color: Colors.blue[900],
//                             fontWeight: FontWeight.normal,
//                             fontSize: 11),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   color: Colors.red[100]),
//               child: GestureDetector(
//                 onTap: () {
//                   launch(
//                       'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
//                   //  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   //  color: primaryBlack,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.highlight_off_outlined,
//                         size: 38,
//                         color: Colors.red,
//                       ),
//                       Text(
//                         'MYTH',
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 11),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   color: Colors.grey[400]),
//               child: GestureDetector(
//                 onTap: () {
//                   // Navigator.push(context,
//                   //     MaterialPageRoute(builder: (context) => NewsPage()));
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
//                   //  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   //  color: primaryBlack,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.article_outlined,
//                         size: 38,
//                         color: Colors.grey[900],
//                       ),
//                       Text(
//                         'NEWS',
//                         style: TextStyle(
//                             color: Colors.grey[900],
//                             fontWeight: FontWeight.normal,
//                             fontSize: 11),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

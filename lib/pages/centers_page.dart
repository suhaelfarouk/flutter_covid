import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_covid/pages/slots_page.dart';
import 'package:http/http.dart' as http;

class CentersPage extends StatefulWidget {
  @override
  _CentersPageState createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  TextEditingController districtCodecontroller = TextEditingController();
  var latestDate = DateTime.now();
  List slots = [];
  String? day;
  String? month;
  String? pincode;

  fetchslots() async {
    pincode = districtCodecontroller.text;
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                pincode! +
                '&date=' +
                day! +
                '-' +
                month! +
                '-2022'))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SlotsPage(slots: slots)));
    });
  }

  @override
  void initState() {
    super.initState();
    day = latestDate.day.toString();
    month = latestDate.month.toString();
  }

  @override
  void dispose() {
    super.dispose();
    districtCodecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.black12,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 115),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Find vaccine \nslots and centers \nnear you.',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextField(
            controller: districtCodecontroller,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: 'Enter District Code',
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 57,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                fetchslots();
              },
              child: Text(
                'Continue',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

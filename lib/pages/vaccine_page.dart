import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_covid/pages/slots_page.dart';
import 'package:http/http.dart' as http;

class VaccinePage extends StatefulWidget {
  @override
  _VaccinePageState createState() => _VaccinePageState();
}

//https://cdn-api.co-vin.in/api/v2/appointment/centers/public/findByLatLong?lat=34.0837&long=74.7973
class _VaccinePageState extends State<VaccinePage> {
  TextEditingController districtCodecontroller = TextEditingController();
  String? dropDownMonthValue;
  String? dropDownDayValue;
  List slots = [];
  fetchslots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                districtCodecontroller.text +
                '&date=' +
                dropDownDayValue! +
                '-' +
                dropDownMonthValue! +
                '-2021'))
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black45
          : Colors.black12,
      //appBar: AppBar(title: Text('Vaccination Slots')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 250,
              // child: Image.asset('assets/vaccine.png'),
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 55,
                    child: DropdownButton<String>(
                      focusColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      hint: Text(
                        'Select Day',
                      ),
                      isExpanded: true,
                      value: dropDownDayValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownDayValue = newValue!;
                        });
                      },
                      items: <String>[
                        '01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
                        '10',
                        '11',
                        '12',
                        '13',
                        '14',
                        '15',
                        '16',
                        '17',
                        '18',
                        '19',
                        '20',
                        '21',
                        '22',
                        '23',
                        '24',
                        '25',
                        '26',
                        '27',
                        '28',
                        '29',
                        '30',
                        '31'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 52,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropDownMonthValue,
                      hint: Text('Month'),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        color: Colors.grey.shade400,
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownMonthValue = newValue!;
                        });
                      },
                      items: <String>[
                        '01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
                        '10',
                        '11',
                        '12'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  fetchslots();
                },
                child: Text('Find Slots'),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_covid/pages/slots_page.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Geolocator geolocator = Geolocator();
  Position? userLocation;

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
      print(userLocation);
    });
  }

  // String latitude = '01.00';
  // String longitude = '01.00';
  List slots = [];
  fetchslots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/centers/public/findByLatLong?lat=' +
                userLocation!.latitude.toStringAsFixed(8) +
                '&long=' +
                userLocation!.longitude.toStringAsFixed(8)))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['centers'];
        // print(slots);
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SlotsPage(slots: slots)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    userLocation!.latitude.toStringAsFixed(8) +
                    " " +
                    userLocation!.longitude.toStringAsFixed(8)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                //color: Colors.blue,
                child: Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}

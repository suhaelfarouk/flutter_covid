import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid/panels/navbar_panel.dart';

class OfflinePage extends StatefulWidget {
  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  var subscription;
  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OfflinePage()),
          );
        });
      } else if (mounted) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavBar()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [Text('No Connection')],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OfflinePage extends StatefulWidget {
  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text('No Connection'))],
        ),
      ),
    );
  }
}

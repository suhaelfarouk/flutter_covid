import 'package:flutter/material.dart';

class SlotsPage extends StatefulWidget {
  final List slots;

  const SlotsPage({Key? key, required this.slots}) : super(key: key);

  @override
  _SlotsPageState createState() => _SlotsPageState();
}

class _SlotsPageState extends State<SlotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Slots')),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              color: Colors.white,
              height: 200,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Center ID - ' +
                          widget.slots[index]['center_id'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Center Name - ' + widget.slots[index]['name'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Center Address - ' +
                          widget.slots[index]['location'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                    Text(
                      'Vaccine Name - ' +
                          widget.slots[index]['block_name'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                    Text(
                      'Slots - ' + widget.slots[index]['pincode'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}

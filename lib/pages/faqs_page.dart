import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';

class FaqsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ'S"),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  DataSource.questionAnswers[index]['question'],
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    DataSource.questionAnswers[index]['answer'],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

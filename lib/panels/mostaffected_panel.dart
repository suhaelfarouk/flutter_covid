import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';

class MostAffectedPanel extends StatelessWidget {
  final List? countryData;

  const MostAffectedPanel({Key? key, required this.countryData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : primaryBlack,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          countryData![index]['countryInfo']['flag'],
                        ),
                        radius: 16,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        countryData![index]['country'],
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        countryData![index]['deaths'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.trending_up),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '+ ' + countryData![index]['critical'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}

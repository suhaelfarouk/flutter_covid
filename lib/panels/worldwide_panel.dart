import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorldWidePanel extends StatefulWidget {
  final Map? worldData;

  const WorldWidePanel({Key? key, required this.worldData}) : super(key: key);

  @override
  State<WorldWidePanel> createState() => _WorldWidePanelState();
}

class _WorldWidePanelState extends State<WorldWidePanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Container(
        child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 83,
          ),
          children: [
            StatusPanel(
              title: 'ACTIVE',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              textColor: Colors.red,
              count: widget.worldData!['active'],
              today: widget.worldData!['critical'],
            ),
            StatusPanel(
              title: 'CONFIRMED',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              textColor: Colors.blue,
              count: widget.worldData!['cases'],
              today: widget.worldData!['todayCases'],
            ),
            StatusPanel(
              title: 'RECOVERED',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              textColor: Colors.green,
              count: widget.worldData!['recovered'],
              today: widget.worldData!['todayRecovered'],
            ),
            StatusPanel(
              title: 'DEATHS',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[350]!
                  : Colors.grey[900]!,
              count: widget.worldData!['deaths'],
              today: widget.worldData!['todayDeaths'],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final int count;
  final int today;

  const StatusPanel(
      {Key? key,
      required this.panelColor,
      required this.textColor,
      required this.title,
      required this.count,
      required this.today})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: width / 2,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: DelayedDisplay(
          delay: Duration(milliseconds: 1200),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      Text(
                        '${(NumberFormat.compact().format(count).toString())}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 27,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 15,
                        color: textColor,
                      ),
                      SizedBox(
                        height: 4,
                        width: 4,
                      ),
                      Text(
                        ('${(NumberFormat.compact().format(today).toString())}'),
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

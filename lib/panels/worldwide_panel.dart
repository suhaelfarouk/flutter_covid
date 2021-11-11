import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorldWidePanel extends StatefulWidget {
  final Map? worldData;

  const WorldWidePanel({Key? key, required this.worldData}) : super(key: key);

  @override
  State<WorldWidePanel> createState() => _WorldWidePanelState();
}

class _WorldWidePanelState extends State<WorldWidePanel>
//with TickerProviderStateMixin
{
  // late final AnimationController _controller1 = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..forward();

  // late final AnimationController _controller2 = AnimationController(
  //   duration: const Duration(seconds: 4),
  //   vsync: this,
  // )..forward();

  // late final AnimationController _controller3 = AnimationController(
  //   duration: const Duration(seconds: 6),
  //   vsync: this,
  // )..forward();

  // late final AnimationController _controller4 = AnimationController(
  //   duration: const Duration(seconds: 8),
  //   vsync: this,
  // )..forward();

  // late final Animation<Offset> _offsetAnimation1 =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
  //         .animate(CurvedAnimation(
  //   parent: _controller1,
  //   curve: Interval(
  //     1.2,
  //     2.0,
  //     curve: Curves.easeOutBack,
  //   ),
  // ));
  // late final Animation<Offset> _offsetAnimation2 =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
  //         .animate(CurvedAnimation(
  //   parent: _controller2,
  //   curve: Interval(
  //     1.4,
  //     2.0,
  //     curve: Curves.easeOutBack,
  //   ),
  // ));
  // late final Animation<Offset> _offsetAnimation3 =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
  //         .animate(CurvedAnimation(
  //   parent: _controller3,
  //   curve: Interval(
  //     1.6,
  //     2.0,
  //     curve: Curves.easeOutBack,
  //   ),
  // ));
  // late final Animation<Offset> _offsetAnimation4 =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
  //         .animate(CurvedAnimation(
  //   parent: _controller4,
  //   curve: Interval(
  //     1.8,
  //     2.0,
  //     curve: Curves.easeOutBack,
  //   ),
  // ));

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller1.dispose();
  //   _controller2.dispose();
  //   _controller3.dispose();
  //   _controller4.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Container(
        //height: 150,
        child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.8, //4.0, //1.8
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 83),
          children: [
            StatusPanel(
              title: 'ACTIVE',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white, //Colors.red[100]!,
              textColor: Colors.red,
              count: widget.worldData!['active'],
              today: widget.worldData!['critical'],
            ),
            StatusPanel(
              title: 'CONFIRMED',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white, //Colors.blue[100]!, //Colors.red[100]!,
              textColor: Colors.blue, //Colors.red,
              count: widget.worldData!['cases'],
              today: widget.worldData!['todayCases'],
            ),
            StatusPanel(
              title: 'RECOVERED',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white, //Colors.green[100]!,
              textColor: Colors.green,
              count: widget.worldData!['recovered'],
              today: widget.worldData!['todayRecovered'],
            ),
            StatusPanel(
              title: 'DEATHS',
              panelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white, //Colors.grey[400]!,
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
      //margin: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      //  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //height: 220,
      width: width / 2,
      //  color: panelColor,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: DelayedDisplay(
          delay: Duration(milliseconds: 1000),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      //SizedBox(height: 2),
                      Text(
                        '${(NumberFormat.compact().format(count).toString())}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Text(
                //   title,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w100,
                //     fontSize: 16,
                //     color: textColor,
                //   ),
                // ),
                // SizedBox(height: 4),
                // Text(
                //   '${(NumberFormat.compact().format(count).toString())}',
                //   style: TextStyle(
                //     fontWeight: FontWeight.w900,
                //     fontSize: 19,
                //     color: textColor,
                //   ),
                // ),
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
                      // AnimatedFlipCounter(
                      //   duration: Duration(seconds: 4),
                      //   value: today,
                      //   textStyle: TextStyle(
                      //       fontWeight: FontWeight.w100,
                      //       fontSize: 16,
                      //       color: textColor),
                      // ),
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

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';
import 'package:intl/intl.dart';

class VaccinePanel extends StatefulWidget {
  final lastVaccine;
  final vaccine;
  final todayVaccine;

  const VaccinePanel(
      {Key? key,
      required this.lastVaccine,
      required this.vaccine,
      required this.todayVaccine})
      : super(key: key);

  @override
  _VaccinePanelState createState() => _VaccinePanelState();
}

class _VaccinePanelState extends State<VaccinePanel>
// with TickerProviderStateMixin
{
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(milliseconds: 5000),
  //   vsync: this,
  // )..forward();
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.linearToEaseOut,
  // );

  // late final AnimationController _controller1 = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..forward();
  // late final Animation<Offset> _offsetAnimation1 =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
  //   CurvedAnimation(
  //     parent: _controller1,
  //     curve: Interval(
  //       0.5,
  //       1.0,
  //       curve: Curves.easeOutBack,
  //     ),
  //   ),
  // );

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    void showBottomSheet(context) {
      showModalBottomSheet(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //constraints: BoxConstraints.tight(Size(250, 250)),
        //elevation: 40,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(),
                ),
              ),
            );
          },
        ),
      );
    }

    Color vacColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.orange[100]!
        : Colors.orange[800]!;
    return InkWell(
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey
            : Colors.grey,
      ),
      enableFeedback: true,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      onTap: () {
        showBottomSheet(context);
      },
      child: Container(
        height: 153,
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 5),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        child: Stack(
          children: [
            Container(
              //height: 90,
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 10, width: 10),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon(
                      //   Icons.info_outlined,
                      //   color: Colors.blue[900],
                      //   size: 38,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 2, left: 4, right: 4),
                        child: Text(
                          'VACCINE',
                          style: TextStyle(
                              color: vacColor, //primaryBlack,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      //SizedBox(height: 5, width: 5),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2, left: 4, right: 4, bottom: 2),
                        child: Text(
                          '${(NumberFormat.compact().format(widget.lastVaccine).toString())}',
                          style: TextStyle(
                              color: vacColor, //primaryBlack,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ),

                      // Text(
                      //   '${(NumberFormat.compact().format(sumVaccine).toString())}',
                      //   style: TextStyle(
                      //       color: Colors.blue[900],
                      //       fontWeight: FontWeight.normal,
                      //       fontSize: 11),
                      // ),
                    ],
                  ),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.center,

                    //Size Transition
                    // sizeFactor: _animation,
                    // axis: Axis.horizontal,
                    // axisAlignment: -1,
                    children: [
                      DelayedDisplay(
                        delay: Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 5, bottom: 10),
                          child: Sparkline(
                            fallbackHeight: 100,
                            fallbackWidth: 240,
                            data: widget.vaccine,
                            pointsMode: PointsMode.last,
                            pointSize: 6.0,
                            pointColor: vacColor, //primaryBlack,
                            useCubicSmoothing: true,
                            cubicSmoothingFactor: 0.1,
                            lineWidth: 3,
                            lineColor: vacColor, //primaryBlack,
                            // fillGradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [Colors.red[200]!, Colors.red[200]!],
                            // ),
                            // fillMode: FillMode.above,
                            // fillColor: Colors.red,
                            //enableThreshold: true,
                            //thresholdSize: 0.00001,
                            //kLine: ['last'],
                            // enableGridLines: true,
                            // gridLineLabelColor: primaryBlack,
                            // gridLineAmount: 2,
                            // gridLineColor: primaryBlack,
                            max: 60000000.0,
                            min: 1.0,
                            // pointsMode: PointsMode.last,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 1, top: 80, left: 1, right: 1),
                      child: Text(
                        'yestereday over the world',
                        style: TextStyle(
                            color: vacColor, //primaryBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 2, top: 80, left: 2, right: 2),
                      child: Text(
                        '${(NumberFormat.compact().format(widget.todayVaccine).toString())}',
                        style: TextStyle(
                            color: vacColor, //primaryBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 1, top: 80, left: 1, right: 1),
                      child: Text(
                        'people were vaccinated.',
                        style: TextStyle(
                            color: vacColor, //primaryBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

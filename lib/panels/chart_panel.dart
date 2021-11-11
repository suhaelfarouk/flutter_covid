import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class ChartPanel extends StatefulWidget {
  final recovered;
  final cases;
  final deaths;

  const ChartPanel(
      {Key? key,
      required this.recovered,
      required this.cases,
      required this.deaths})
      : super(key: key);

  @override
  State<ChartPanel> createState() => _ChartPanelState();
}

class _ChartPanelState extends State<ChartPanel>
//with TickerProviderStateMixin
{
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..forward();
  // late final Animation<Offset> _offsetAnimation =
  //     Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
  //         .animate(CurvedAnimation(
  //             parent: _controller,
  //             curve: Interval(
  //               1.8,
  //               2.0,
  //               curve: Curves.easeOutBack,
  //             )));

  @override
  Widget build(BuildContext context) {
    return Stack(
      //clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      //fit: StackFit.loose,
      children: [
        DelayedDisplay(
          delay: Duration(milliseconds: 1500),
          child: Sparkline(
            data: widget.cases,
            useCubicSmoothing: true,
            cubicSmoothingFactor: 0.1,
            lineWidth: 3,
            lineColor: Colors.blue,
            fillGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.blue[900]!
                    : Colors.blue[300]!,
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
              ],
            ),
            fillMode: FillMode.below,

            // fillColor: Colors.red,
            // enableThreshold: true,
            // thresholdSize: 0.5,
            //kLine: ['last'],
            //enableGridLines: true,
            // gridLineLabelColor: primaryBlack,
            // gridLineAmount: 2,
            // gridLineColor: primaryBlack,
            max: 900000.0,
            min: 1.0,
            // pointsMode: PointsMode.last,
          ),
        ),
        widget.recovered == null
            ? Container()
            : DelayedDisplay(
                delay: Duration(milliseconds: 1500),
                child: Sparkline(
                  data: widget.recovered,
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.1,
                  lineWidth: 3,
                  lineColor: Colors.green,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.green[900]!
                          : Colors.green[300]!,
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ],
                  ),

                  // fillColor: Colors.black,
                  // enableThreshold: true,
                  // thresholdSize: 0.5,
                  // kLine: ['last'],
                  // enableGridLines: true,
                  // gridLineLabelColor: primaryBlack,
                  // gridLineAmount: 2,
                  // gridLineColor: primaryBlack,
                  max: 900000,
                  //600000.0,
                  //600000.0,
                  min: 1.0,
                ),
              ),

        widget.deaths == null
            ? Container()
            : DelayedDisplay(
                delay: Duration(milliseconds: 1500),
                child: Sparkline(
                  data: widget.deaths,
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.1,
                  lineWidth: 3,
                  lineColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]!
                      : Colors.grey[900]!,
                  //fillMode: FillMode.below,
                  // fillGradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [Colors.grey[900]!, Colors.white],
                  // ),
                  // enableThreshold: true,
                  // thresholdSize: 0.5,
                  // kLine: ['last'],
                  // enableGridLines: true,
                  // gridLineLabelColor: primaryBlack,
                  // gridLineAmount: 2,
                  // gridLineColor: primaryBlack,
                  max: 200000.0,
                  min: 1.0,
                ),
              ),

        // Container(
        //   height: 170,
        //   decoration: BoxDecoration(
        //     color: Colors.orange[100],
        //     borderRadius: BorderRadius.all(Radius.circular(8)),
        //   ),
        // ),
        DelayedDisplay(
          delay: Duration(milliseconds: 1500),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Text(
              'the charts present the data of last 30 days.',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

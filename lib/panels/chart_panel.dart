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

class _ChartPanelState extends State<ChartPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      height: 143,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: 1700),
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
              max: 1200000.0,
              min: 1.0,
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 1700),
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
              max: 900000,
              min: 1.0,
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 1700),
            child: Sparkline(
              data: widget.deaths,
              useCubicSmoothing: true,
              cubicSmoothingFactor: 0.1,
              lineWidth: 3,
              lineColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]!
                  : Colors.grey[900]!,
              max: 200000.0,
              min: 1.0,
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 1700),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90.0),
              child: Text(
                'the charts present the data of last 30 days.',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

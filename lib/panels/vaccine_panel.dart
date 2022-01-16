import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class VaccinePanel extends StatefulWidget {
  final lastVaccine;
  final vaccine;
  final todayVaccine;
  final totalVaccine;
  final highestVaccine;

  const VaccinePanel(
      {Key? key,
      required this.lastVaccine,
      required this.vaccine,
      required this.todayVaccine,
      required this.totalVaccine,
      required this.highestVaccine})
      : super(key: key);

  @override
  _VaccinePanelState createState() => _VaccinePanelState();
}

class _VaccinePanelState extends State<VaccinePanel> {
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,###,000');
    Color vacColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.orange[100]!
        : Colors.orange[800]!;
    void showBottomSheet(context) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DraggableScrollableSheet(
                    initialChildSize: .3,
                    minChildSize: .2,
                    maxChildSize: .3,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Stack(children: [
                        Positioned(
                          left: 240,
                          bottom: 160,
                          child: Text(
                              '${(NumberFormat.compact().format(widget.highestVaccine).toString())}'),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          child: Sparkline(
                            fallbackWidth: 5000,
                            data: widget.totalVaccine,
                            lineColor: vacColor,
                            // pointsMode: PointsMode.all,
                            // pointSize: 4,
                            pointColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.orange[800]!
                                    : Colors.orange[100]!,
                            lineWidth: 4,
                            sharpCorners: true,
                            fillMode: FillMode.below,
                            fillGradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.orange[100]!
                                    : Colors.orange[100]!,
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                              ],
                            ),

                            //max: 100000000,
                          ),
                        ),
                      ]);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

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
        height: 143,
        padding: EdgeInsets.only(right: 15, left: 15, top: 15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VACCINE',
                    style: TextStyle(
                      color: vacColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    // formatter.format(widget.lastVaccine).toString(),
                    '${(NumberFormat.compact().format(widget.lastVaccine).toString())}',
                    style: TextStyle(
                      color: vacColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                DelayedDisplay(
                  delay: Duration(milliseconds: 700),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 0,
                      right: 0,
                      bottom: 0,
                    ),
                    child: Sparkline(
                      fallbackHeight: 115,
                      fallbackWidth: 240,
                      data: widget.vaccine,
                      useCubicSmoothing: true,
                      cubicSmoothingFactor: 0.1,
                      lineWidth: 3,
                      lineColor: vacColor,
                      fillMode: FillMode.below,
                      fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.orange[100]!
                              : Colors.orange[100]!,
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ],
                      ),
                      max: 80000000.0,
                      min: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 13,
                      color: vacColor,
                    ),
                    SizedBox(
                      height: 4,
                      width: 4,
                    ),
                    Text(
                      formatter.format(widget.todayVaccine).toString(),
                      // '${(NumberFormat.compact().format(widget.todayVaccine).toString())}',
                      style: TextStyle(
                        color: vacColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
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

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

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

class _VaccinePanelState extends State<VaccinePanel> {
  @override
  Widget build(BuildContext context) {
    void showBottomSheet(context) {
      showModalBottomSheet(
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
        height: 143,
        padding: EdgeInsets.only(right: 15, left: 15, bottom: 0, top: 10),
        margin: EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 2,
                      left: 4,
                      right: 4,
                    ),
                    child: Text(
                      'VACCINATION DRIVE',
                      style: TextStyle(
                        color: vacColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2,
                      left: 4,
                      right: 4,
                      bottom: 2,
                    ),
                    child: Text(
                      '${(NumberFormat.compact().format(widget.lastVaccine).toString())}',
                      style: TextStyle(
                        color: vacColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 27,
                      ),
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
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 20,
                    ),
                    child: Sparkline(
                      fallbackHeight: 100,
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
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                        top: 90,
                        left: 1,
                        right: 1,
                      ),
                      child: Text(
                        'yestereday',
                        style: TextStyle(
                          color: vacColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 2,
                        top: 90,
                        left: 2,
                        right: 2,
                      ),
                      child: Text(
                        '${(NumberFormat.compact().format(widget.todayVaccine).toString())}',
                        style: TextStyle(
                          color: vacColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                        top: 90,
                        left: 1,
                        right: 1,
                      ),
                      child: Text(
                        'doses were adminstered.',
                        style: TextStyle(
                          color: vacColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
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

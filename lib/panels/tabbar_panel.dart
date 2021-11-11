import 'package:flutter/material.dart';
import 'package:flutter_covid/pages/country_page.dart';
import 'package:flutter_covid/pages/states_page.dart';

import '../datasource.dart';

class TabBarPanel extends StatelessWidget {
  const TabBarPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: TabBar(
              labelColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : primaryBlack,
              indicatorColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : primaryBlack,
              indicatorPadding: EdgeInsets.zero,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'Countries',
                ),
                Tab(
                  text: 'States',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [CountryPage(), StatesPage()]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_covid/pages/anews_page.dart';
import 'package:flutter_covid/pages/bnews_page.dart';
import 'package:flutter_covid/pages/cnews_page.dart';

import '../datasource.dart';

class NewsBarPanel extends StatelessWidget {
  const NewsBarPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  text: 'Global',
                ),
                Tab(
                  text: 'India',
                ),
                Tab(
                  text: 'Local',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [AnewsPage(), BnewsPage(), CnewsPage()]),
      ),
    );
  }
}

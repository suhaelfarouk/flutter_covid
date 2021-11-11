import 'package:flutter/material.dart';
import 'package:flutter_covid/models/news_api.dart';
import 'package:flutter_covid/models/news_model.dart';
import 'package:flutter_covid/pages/reading_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsApiModel>? newsList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Icon(Icons.menu),
                    SizedBox(
                      width: size.width / 4,
                    ),
                    Text(
                      "News App",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return listItems(size, newsList![index], context);
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Widget listItems(Size size, NewsApiModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
    child: GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ReadingPage(
            model: model,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        width: size.width / 1.15,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: Column(
          children: [
            Container(
              height: size.height / 4,
              width: size.width / 1.05,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: model.imageUrl != ""
                  ? Image.network(
                      model.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Text("Cant Load image"),
            ),
            Container(
              width: size.width / 1.1,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                model.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: size.width / 1.1,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                model.description,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

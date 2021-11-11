import 'dart:convert';

import 'package:flutter_covid/models/news_model.dart';
import 'package:http/http.dart' as http;

Future<List<NewsApiModel>> getNews() async {
  Uri url = Uri.parse(
      //"https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=bdd26715db6e42cfb697b7ce7a5d36ef");

      //  "http://newsapi.org/v2/everything?q=covid&apiKey=bdd26715db6e42cfb697b7ce7a5d36ef");
      "http://newsapi.org/v2/everything?q=covid%20cases&apiKey=bdd26715db6e42cfb697b7ce7a5d36ef");
  final response = await http.get(url);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<NewsApiModel> newsList = _articalsList
        .map((jsonData) => NewsApiModel.fromJson(jsonData))
        .toList();

    //print(_articalsList);

    return newsList;
  } else {
    print("Error");
    return [];
  }
}

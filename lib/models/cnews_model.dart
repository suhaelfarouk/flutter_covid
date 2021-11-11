// // To parse this JSON data, do
// //
// //     final cnewsModel = cnewsModelFromJson(jsonString);

// import 'dart:convert';

// CnewsModel cnewsModelFromJson(String str) => CnewsModel.fromJson(json.decode(str));

// String cnewsModelToJson(CnewsModel data) => json.encode(data.toJson());

// class CnewsModel {
//     CnewsModel({
//         required this.articles,
//     });

//     List<Article> articles;

//     factory CnewsModel.fromJson(Map<String, dynamic> json) => CnewsModel(
//         articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
//     };
// }

// class Article {
//     Article({
//         required this.title,
//         this.author,
//         required this.publishedDate,
//         required this.link,
//         required this.cleanUrl,
//         required this.summary,
//         required this.rights,
//         required this.media,
//     });

//     String title;
//     dynamic author;
//     DateTime publishedDate;
//     String link;
//     String cleanUrl;
//     String summary;
//     String rights;
//     String media;

//     factory Article.fromJson(Map<String, dynamic> json) => Article(
//         title: json["title"],
//         author: json["author"],
//         publishedDate: DateTime.parse(json["published_date"]),
//         link: json["link"],
//         cleanUrl: json["clean_url"],
//         summary: json["summary"],
//         rights: json["rights"],
//         media: json["media"],
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "author": author,
//         "published_date": publishedDate.toIso8601String(),
//         "link": link,
//         "clean_url": cleanUrl,
//         "summary": summary,
//         "rights": rights,
//         "media": media,
//     };
// }

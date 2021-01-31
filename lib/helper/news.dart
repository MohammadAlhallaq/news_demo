import 'dart:convert';

import 'package:news_demo/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/everything?q=tesla&from=2020-12-30&sortBy=publishedAt&apiKey=3200b50e05f84c1bbd605f59180e5b22";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData.status == "ok") {
      jsonData["articles"].forEach((el) {
        if (el["urlToImage"] != null && el['description']) {
          ArticleModel articleModel = ArticleModel(
              author: el['author'],
              title: el["title"],
              description: el['description'],
              url: el["url"],
              urlToImage: el["urlToImage"],
              content: el["content"],
              publishedAt: el["publishedAt"]);
          news.add(articleModel);
        }
      });
      return news;
    }
  }
}

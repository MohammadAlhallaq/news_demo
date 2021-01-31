import 'package:flutter/material.dart';
import 'package:news_demo/helper/data.dart';
import 'package:news_demo/helper/news.dart';
import 'package:news_demo/models/article_model.dart';
import 'package:news_demo/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsInst = News();
    await newsInst.getNews();
    articles = newsInst.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text('News', style: TextStyle(color: Colors.blue)),
          ],
        ),
        centerTitle: true,
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue))
          : Container(
              child: Column(
                children: [
                  //CATEGORIES
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 70,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          print('Text');
                          return CategoryTitle(
                              categoryName: categories[index].categoryName,
                              iamgeUrl: categories[index].imageUrl);
                        },
                      )),

                  ///BLOGS
                  // Container(
                  //   child: ListView.builder(
                  //     itemCount: articles.length,
                  //     itemBuilder: (context, index) {
                  //       return BlogTitle(
                  //         imageUrl: articles[index].urlToImage,
                  //         title: articles[index].title,
                  //         desc: articles[index].description,
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  @override
  final categoryName, iamgeUrl;
  CategoryTitle({this.categoryName, this.iamgeUrl});

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                iamgeUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(6)),
              width: 120,
              height: 60,
              child: Text(categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTitle extends StatelessWidget {
  @override
  final String imageUrl, title, desc;

  BlogTitle({this.imageUrl, this.title, this.desc});

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(title),
          Text(desc),
        ],
      ),
    );
  }
}

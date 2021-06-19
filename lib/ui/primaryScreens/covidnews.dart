import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class News {
  String author;
  String title;
  String description;
  String url;
  String publishedAt;
  String sourcename;
  String launchurl;

  News(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.publishedAt,
      this.sourcename,
      this.launchurl});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        author: json['author'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['urlToImage'] as String,
        publishedAt: json['publishedAt'] as String,
        sourcename: json['source']['name'] as String,
        launchurl: json['url'] as String);
  }
}

String api =
    "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=354ccddf2535462483ac3f828d25d788";

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  void initState() {
    super.initState();

    refreshList();
  }

  bool loading = false;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<News> ls_news;
  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse(api));
    final res = jsonDecode(response.body);
    return (res["articles"] as List)
        .map<News>((json) => new News.fromJson(json))
        .toList();
  }

  Future<Null> refreshList() async {
    if (this.mounted) {
      setState(() {
        loading = true;
      });
    }
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    ls_news = await getNews();
    if (this.mounted) {
      setState(() {
        loading = false;
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News Feed",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: RefreshIndicator(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                )
              : ListView.builder(
                  itemCount: ls_news == null ? 0 : ls_news.length,
                  padding: new EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Card(
                        elevation: 1.7,
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Column(
                            children: [
                              new Row(
                                children: <Widget>[
                                  new Padding(
                                    padding: new EdgeInsets.only(left: 4.0),
                                    child: new Text(
                                      timeago.format(DateTime.parse(
                                          ls_news[index]
                                              .publishedAt
                                              .toString())),
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(5.0),
                                    child: new Text(
                                      ls_news[index].sourcename != null
                                          ? ls_news[index].sourcename
                                          : "NDTV",
                                      style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              new Row(
                                children: [
                                  new Expanded(
                                    child: new GestureDetector(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 8.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: new Text(
                                              ls_news[index].title.toString() !=
                                                      null
                                                  ? ls_news[index]
                                                      .title
                                                      .toString()
                                                  : "Corona Virus",
                                              style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.only(
                                                left: 4.0,
                                                right: 4.0,
                                                bottom: 4.0),
                                            child: new Text(
                                              ls_news[index].description != null
                                                  ? ls_news[index].description
                                                  : "",
                                              style: new TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DescriptionPage(
                                                        ls_news[index]
                                                            .launchurl
                                                            .toString())));
                                      },
                                    ),
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      new Padding(
                                        padding: new EdgeInsets.only(top: 8.0),
                                        child: new SizedBox(
                                          height: 100.0,
                                          width: 100.0,
                                          child: new Image.network(
                                            ls_news[index].url != null
                                                ? ls_news[index].url
                                                : "https://image.shutterstock.com/image-vector/illustration-flat-icon-tv-channel-260nw-482689633.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          onRefresh: refreshList,
        ));
  }
}

class DescriptionPage extends StatelessWidget {
  static String tag = 'description-page';

  DescriptionPage(this.urlnews);
  final String urlnews;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Full Article",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WebviewScaffold(
          url: urlnews,
          withJavascript: true,
          hidden: true,
          initialChild: Container(
            child: const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
            ),
          ),
        ),
      ),
    );
  }
}

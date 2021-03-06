import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsView createState() => new _NewsView();
}

class _NewsView extends State<NewsView> {
  //articles per source
  List<dynamic> mainHeadlineArticles =
      UserInformation.getNewsBasedOnTopic('headlines');
  List<dynamic> usHeadlineArticles =
      UserInformation.getNewsBasedOnTopic('usheadlines');
  List<dynamic> sportsHeadlineArticles =
      UserInformation.getNewsBasedOnTopic('sportHeadlines');
  List<dynamic> healthHeadlineArticles =
      UserInformation.getNewsBasedOnTopic('healthHeadlines');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff131d47),
        appBar: AppBar(
          backgroundColor: Color(0xff131d47),
          title: new Text('News Reports'),
          bottom: TabBar(tabs: <Widget>[
            new Text('Top Stories',
                style: TextStyle(
                  fontSize: 18,
                )),
            new Text('US',
                style: TextStyle(
                  fontSize: 18,
                )),
            new Text('Health',
                style: TextStyle(
                  fontSize: 18,
                )),
            new Text('Sports',
                style: TextStyle(
                  fontSize: 18,
                )),
          ]),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          //you can change the center widget to another widget that would
          //fit your need better.
          children: <Widget>[
            Center(
              //child for the main headlines
              child: ListView.builder(
                itemCount: mainHeadlineArticles.length,
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return CreateNewsCard(mainHeadlineArticles, index);
                },
              ),
            ),
            Center(
              //child for the us headlines
              child: ListView.builder(
                itemCount: usHeadlineArticles.length,
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return CreateNewsCard(usHeadlineArticles, index);
                },
              ),
            ),
            Center(
              //child for the health headlines
              child: ListView.builder(
                itemCount: healthHeadlineArticles.length,
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return CreateNewsCard(healthHeadlineArticles, index);
                },
              ),
            ),
            Center(
              //child for the sports headlines
              child: ListView.builder(
                itemCount: sportsHeadlineArticles.length,
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return CreateNewsCard(sportsHeadlineArticles, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //create the NewsCard
  Widget CreateNewsCard(List<dynamic> source, int index) {
    dynamic currentArticle = source[index];
    return NewsCard(
        currentArticle['title'],
        currentArticle['description'],
        currentArticle['source']['name'],
        currentArticle['publishedAt'],
        currentArticle['url'],
        currentArticle['urlToImage'],
        currentArticle['content']);
  }
}

class NewsCard extends StatefulWidget {
  String articleTitle,
      articleDescription,
      articleSource,
      articleUrl,
      articleUrlToImage,
      articleContent;
  DateTime articlePublishedAt;

  NewsCard(String title, String description, String source, String publishedAt,
      String articleUrl, String urlToImage, String content) {
    this.articleTitle = title;
    this.articleDescription = description;
    this.articleSource = source;
    this.articlePublishedAt = DateTime.parse(publishedAt);
    this.articleUrl = articleUrl;
    this.articleUrlToImage = urlToImage;
    this.articleContent = content;
  }

  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  double cardHeight, cardWidth;
  bool isCardExpanded;

  initState() {
    cardHeight = 350;
    cardWidth = 350;
    isCardExpanded = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _launchArticleUrl,
      onLongPress: _changeCardSize,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: cardHeight,
        width: cardWidth,
        child: Card(
            borderOnForeground: true,
            shadowColor: Colors.grey,
            color: Color(0xffd3d8e0),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.zero,
                      child: widget.articleUrlToImage != null
                          ? Image.network(
                              widget.articleUrlToImage,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : CircularProgressIndicator();
                              },
                            )
                          : Text("No Image Available",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 24)),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(widget.articleTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Verdana",
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                      flex: isCardExpanded ? 6 : 0,
                      child: viewContentBasedOnCardExpanded()),
                  Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Text(DateFormat("MMMM dd, yyyy  hh:mm a")
                                  .format(widget.articlePublishedAt))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.desktop_windows),
                              Text(widget.articleSource,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }

  _launchArticleUrl() async {
    String url = widget.articleUrl;
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _changeCardSize() {
    setState(() {
      cardHeight = !isCardExpanded ? cardHeight * 1.5 : cardHeight / 1.5;
      isCardExpanded = !isCardExpanded;
    });
  }

  //adding items when card is expanded
  Widget viewContentBasedOnCardExpanded() {
    if (isCardExpanded) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 5,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Description: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                    text: widget.articleDescription,
                    style: TextStyle(color: Colors.black))
              ]),
            ),
          ),
          Flexible(
            flex: 4,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Content: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                    text: widget.articleContent,
                    style: TextStyle(color: Colors.black))
              ]),
            ),
          ),
          Flexible(
            flex: 4,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Article URL: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: widget.articleUrl != null
                        ? widget.articleUrl
                        : "No Link Available",
                    recognizer: widget.articleUrl != null
                        ? (TapGestureRecognizer()
                          ..onTap = () => _launchArticleUrl())
                        : (TapGestureRecognizer()
                          ..onTap = () => print("No article")),
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline))
              ]),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

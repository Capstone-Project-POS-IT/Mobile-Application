import 'dart:io';
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
  List<dynamic> mainHeadlineArticles = UserInformation.getNewsBasedOnTopic(
      'headlines');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      //initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff131d47),
        appBar: AppBar(
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
              child: ListView.builder(
                itemCount: mainHeadlineArticles.length,
                cacheExtent: 100,
                itemBuilder: (context, index) {
                  return CreateNewsCard(mainHeadlineArticles, index);
                },
              ),
            ),
            Center(
              child: Text('child body 2'),
            ),
            Center(
              child: Text('child body 3'),
            ),
            Center(
              child: Text('child body 4'),
            ),
          ],
        ),
      ),
    );
  }

  //create the NewsCard
  Widget CreateNewsCard(List<dynamic> source, int index) {
    dynamic currentArticle = source[index];
    return NewsCard();
  }

}


class NewsCard extends StatefulWidget {
  // String title,
  //     description,
  //     source,
  //     publishedAt,
  //     articleUrl,
  //     urlToImage,
  //     content;
  //
  // NewsCard(String title, String description,String source,String publishedAt,String articleUrl,String urlToImage,String content){
  //   this.title = title;
  //   this.source = source;
  //   this.publishedAt = publishedAt;
  //   this.articleUrl = articleUrl;
  //   this.urlToImage = urlToImage;
  //   this.content = content;
  // }

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

  String articleTitle =
      "Labor challenges Coalition on jobmaker disadvantages for older workers – politics live";
  String articleDescription =
      "Government says young Australians face highest rate of unemployment and denies hiring credit will result in age discrimination. Follow the latest updates";
  String articleSource = "Google News (Australia)";
  DateTime articlePublishedAt = DateTime.parse("2020-11-12T05:42:00+00:00");
  String articleUrl =
      "https://www.theguardian.com/australia-news/live/2020/nov/12/albanese-anthem-federal-icac-nsw-queensland-victoria-morrison-live-news";
  String articleUrlToImage =
      "https://i.guim.co.uk/img/media/3da1f4ffc5b6514c272554b2d63f74fad5139659/0_202_5472_3283/master/5472.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctbGl2ZS5wbmc&enable=upscale&s=f65242851015ef352a8ee0e80e1482d5";
  String articleContent =
      "Government says young Australians face highest rate of unemployment and denies hiring credit will result in age discrimination. Follow the latest updates";

  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _launchArticleUrl,
      onLongPress: changeCardSize,
      child: Container(
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
                      child: Image.network(articleUrlToImage),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(articleTitle,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Text(DateFormat("MM-dd-yyyy")
                                  .format(DateTime.now()))
                            ],
                          ),
                          Row(
                            children: [Icon(Icons.source), Text(articleSource)],
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
    // if(await canLaunch(articleUrl)){
    //   await launch(articleUrl);
    // }
    // else{
    //   print("The link cannot be opened to $articleUrl");
    // }
    await launch(articleUrl);
  }

  Future<void> changeCardSize() {
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
                    text: articleDescription,
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
                    text: articleContent, style: TextStyle(color: Colors.black))
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
                    text: articleUrl,
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
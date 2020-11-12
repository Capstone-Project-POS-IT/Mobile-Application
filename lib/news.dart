import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsView createState() => new _NewsView();
}

class _NewsView extends State<NewsView> {
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
              child: NewsCard(),
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
}

class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
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
      child: Container(
        height: 375,
        width: 375,
        padding: EdgeInsets.all(15),
        child: Card(
          borderOnForeground: true,
          shadowColor: Colors.grey,
          color: Color(0xffd3d8e0),
          child: Column(
            children: <Widget>[
              Text(articleTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Calibri", fontSize: 20)),
              Text(articleDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Garamond", fontSize: 15)),
              Container(
                width: 300,
                height: 150,
                color: Colors.redAccent,
                child: new Image.network(articleUrlToImage),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(DateFormat('yyyy-MM-dd').format(DateTime
                        .now()) //using current datetime for testing right now
                    ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(articleSource, style: TextStyle(fontSize: 10)),
              )
            ],
          ),
        ),
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
}

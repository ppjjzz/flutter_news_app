import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/entity/hot_words.dart';
import 'package:flutter_news_app/index/index_body.dart';
import 'package:http/http.dart' as http;

class Index extends StatefulWidget {
  @override
  IndexState createState() => new IndexState();
}

class IndexState extends State<Index> {
  Future<HotWords> hotWords;

  Future<HotWords> fetchHotWords() async {
    final response =
        await http.get('https://is.snssdk.com/search/suggest/homepage_suggest');
    if (response.statusCode == 200) {
      return HotWords.fromJson(json.decode(response.body));
    } else {
      throw Exception('获取热搜关键字失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        titleSpacing: 15,
        iconTheme: IconThemeData(color: Colors.grey),
        title: new Container(
          height: 40,
          padding: EdgeInsets.all(8.0),
          // 盒子样式
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: GestureDetector(
            onTap: () => null,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search),
                  Expanded(
                      child: FutureBuilder<HotWords>(
                          future: hotWords,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: EdgeInsets.only(right: 7.0),
                                child: Text(
                                  snapshot.data.data.homepage_search_suggest,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                  new Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    // 盒子样式
                    decoration: new BoxDecoration(
                      border: new BorderDirectional(
                        start: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: Text(
                      '热搜',
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ]),
          ),
        ),
      ),
      body: IndexBody(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotWords = fetchHotWords();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Index oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

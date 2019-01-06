import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/entity/category.dart';
import 'package:flutter_news_app/index/news_list.dart';
import 'package:http/http.dart' as http;

class IndexBody extends StatefulWidget {
  @override
  IndexBodyState createState() => new IndexBodyState();
}

class IndexBodyState extends State<IndexBody> {
  Future<Category> category;

  Future<Category> fetchCategory() async {
    final response = await http
        .get('https://is.snssdk.com/article/category/get_subscribed/v1/');
    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('获取类目列表失败');
    }
  }

  Widget genTabContent({String category}) {
    switch (category) {
      case 'news_hot':
      case 'news_local':
      case 'news_entertainment':
      case 'news_tech':
      case 'news_car':
      case 'news_finance':
      case 'news_military':
      case 'news_sports':
      case 'news_world':
      case 'news_health':
      case 'news_house':
      case 'traditional_culture':
        return NewsList(
          category: category,
        );
      default:
        return Text(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category>(
        future: category,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Widget> list = [];
            for (var i in snapshot.data.data.data) {
              list.add(Tab(
                text: i.name,
              ));
            }

            return DefaultTabController(
                length: list.length,
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new Container(
                      // 盒子样式
                      decoration: new BoxDecoration(
                          //设置Border属性给容器添加边框
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: Colors.grey))),
                      child: TabBar(
                        tabs: list,
                        isScrollable: true,
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(fontSize: 16),
                        indicatorPadding: EdgeInsets.only(bottom: 5.0),
                        indicatorWeight: 0.1,
                        indicatorColor: Colors.transparent,
                      ),
                    ),
                    Flexible(
                        child: TabBarView(
                            children: snapshot.data.data.data
                                .map((item) =>
                                    genTabContent(category: item.category))
                                .toList())),
                  ],
                ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = fetchCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(IndexBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

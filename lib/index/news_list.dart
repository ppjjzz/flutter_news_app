import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_news_app/component/news_bottom_label.dart';
import 'package:flutter_news_app/entity/multi_img_news_item.dart';
import 'package:flutter_news_app/entity/none_img_news_item.dart';
import 'package:flutter_news_app/entity/original_list.dart';
import 'package:flutter_news_app/entity/single_img_news_item.dart';
import 'package:flutter_news_app/entity/video_news_item.dart';
import 'package:http/http.dart' as http;

class NewsList extends StatefulWidget {
  final String category;
  NewsList({
    @required this.category,
  });
  @override
  NewsListState createState() => new NewsListState(category: category);
}

class NewsListState extends State<NewsList> with AutomaticKeepAliveClientMixin {
  String refreshedText;
  int lastTime;
  final String category;
  List<dynamic> listData = [];
  NewsListState({@required this.category});

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  Future<Null> _onRefresh({bool loadMore = false}) async {
    final String loadMethod = loadMore ? 'load_more' : 'pull';
    final String behotTime = loadMore ? 'max_behot_time' : 'min_behot_time';
    final List<dynamic> list = [];
    final now = new DateTime.now().millisecondsSinceEpoch;
    final time = (now / 1000).floor();
    print(
        'https://is.snssdk.com/api/news/feed/v75/?category=$category&$behotTime=$time&tt_from=$loadMethod');
    final response = await http.get(
        'https://is.snssdk.com/api/news/feed/v75/?category=$category&$behotTime=$time&tt_from=$loadMethod&refer=1');
    if (response.statusCode == 200) {
      final originalList = OriginalList.fromJson(json.decode(response.body));
      for (var item in originalList.data) {
        var content = json.decode(item.content);
        if (content['title'] == null) {
          continue;
        }
        if (content['has_video']) {
          print("video!!!");
          // 视频
          list.add(VideoNewsItem.fromJson(content));
        } else {
          if (content['has_image'] == null || !content['has_image']) {
            // 无图
            list.add(NoneImgNewsItem.fromJson(content));
          } else if (content['has_image']) {
            if (content['image_list'] == null) {
              // 单图
              list.add(SingleImgNewsItem.fromJson(content));
            } else {
              // 多图
              list.add(MultiImgNewsItem.fromJson(content));
            }
          }
        }
      }
//      list.removeWhere((item) => item['label'] == '广告');
      setState(() {
        if (!loadMore) {
          refreshedText = originalList.tips.displayInfo;
          listData.clear();
        }
        listData.addAll(list);
      });
    } else {
      throw Exception('获取类目列表失败');
    }
  }

  Future<Null> _loadMore() async {
    _onRefresh(loadMore: true);
  }

  Widget _getRow(item) {
    if (item is NoneImgNewsItem) {
      return _getNoneImgNewsItem(item);
    } else if (item is SingleImgNewsItem) {
      return _getSingleImgNewsItem(item);
    } else if (item is MultiImgNewsItem) {
      return _getMultiImgNewsItem(item);
    } else if (item is VideoNewsItem) {
      return _getVideoNewsItem(item);
    }
  }

  Widget _getNoneImgNewsItem(NoneImgNewsItem item) {
    return new Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
          NewsBottomLabel(
            source: item.source,
            commentCount: item.commentCount,
            label: item.hot == 1 ? '热' : null,
            cursor: item.cursor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              height: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _getSingleImgNewsItem(SingleImgNewsItem item) {
    return new Container(
//      height: 230,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
      child: Column(
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 255,
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                    NewsBottomLabel(
                      source: item.source,
                      commentCount: item.commentCount,
                      label: item.hot == 1 ? '热' : null,
                      cursor: item.cursor,
                    ),
                  ],
                ),
              ),
              Container(
                height: 85,
                child: Image.network(
                  item.middleImage.url,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              height: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _getMultiImgNewsItem(MultiImgNewsItem item) {
    return new Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: item.imageList.map((imageItem) {
              return Container(
                height: 85,
                child: Image.network(
                  imageItem.url,
                  fit: BoxFit.fitHeight,
                ),
              );
            }).toList(),
          ),
          NewsBottomLabel(
            source: item.source,
            commentCount: item.commentCount,
            label: item.hot == 1 ? '热' : null,
            cursor: item.cursor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              height: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _getVideoNewsItem(VideoNewsItem item) {
    var imgUrl = (item.largeImageList != null && item.largeImageList.isNotEmpty)
        ? item.largeImageList[0].url
        : item.middleImage.url;
    return new Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Image.network(
            imgUrl,
            fit: BoxFit.fitWidth,
          ),
          NewsBottomLabel(
            source: item.source,
            commentCount: item.commentCount,
            label: item.hot == 1 ? '热' : null,
            cursor: item.cursor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              height: 0,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return EasyRefresh(
        key: _easyRefreshKey,
        autoLoad: true,
        child: ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              final item = listData[index];
              return _getRow(item);
            }),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: "下拉推荐",
          refreshReadyText: '松开推荐',
          refreshingText: '推荐中',
          refreshedText: refreshedText,
          bgColor: Color.fromRGBO(244, 245, 245, 1.0),
          textColor: Color.fromRGBO(103, 103, 103, 1.0),
          moreInfoColor: Colors.black54,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadedText: '上拉加载更多',
          loadReadyText: '松开加载',
          loadingText: '正在努力加载',
          bgColor: Color.fromRGBO(244, 245, 245, 1.0),
          textColor: Color.fromRGBO(103, 103, 103, 1.0),
          moreInfoColor: Colors.black54,
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(NewsList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

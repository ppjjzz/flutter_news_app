import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/component/news_label.dart';

class NewsBottomLabel extends StatelessWidget {
  final String label;
  final String source;
  final int commentCount;
  final int cursor;
  NewsBottomLabel(
      {@required this.source,
      @required this.commentCount,
      this.label,
      this.cursor});

  String _getTimeLine(int time) {
//    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return TimelineUtil.format(time);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = [];
    if (label != null) {
      rowChildren.add(Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: NewsLabel(text: label),
      ));
    }
    rowChildren.add(Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Text(
        source,
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    ));
    rowChildren.add(Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Text(
        "$commentCount评论",
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    ));
    if (cursor != null) {
      rowChildren.add(Text(
        _getTimeLine(cursor),
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ));
    }
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: new Row(
        children: rowChildren,
      ),
    );
  }
}

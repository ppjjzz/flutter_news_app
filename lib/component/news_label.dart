import 'package:flutter/material.dart';

class NewsLabel extends StatelessWidget {
  final String text;
  final Color color;
  NewsLabel({@required this.text, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 2.5, right: 2.5),
      // 盒子样式
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.5)),
        //设置Border属性给容器添加边框
        border: new Border.all(
          //为边框添加颜色
          color: color,
          width: 0.5, //边框宽度
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
        ),
      ),
    );
  }
}

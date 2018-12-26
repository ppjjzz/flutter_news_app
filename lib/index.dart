import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
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
                Expanded(child: Text('黄埔有轨电车2号线 | 迎苹果史上最大促销活动', overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),)),
                new Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  // 盒子样式
                  decoration: new BoxDecoration(
                    border: new BorderDirectional(
                      start: BorderSide(
                        color: Colors.grey,
                        width: 1.0
                      ),
                    ),
                  ),
                  child: Text('热搜', style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.w800),),
                )]
            ),
          ),
        ),
      )
    );
  }
}
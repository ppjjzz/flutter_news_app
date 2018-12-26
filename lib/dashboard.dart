import 'package:flutter/material.dart';
import 'package:flutter_news_app/index.dart';
import 'package:flutter_news_app/person.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  int _pageIdx = 0;
  PageController _pageCtl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageCtl = PageController(initialPage: _pageIdx);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageCtl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: PageView(
          controller: _pageCtl,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _pageIdx = index),
          children: <Widget>[
            Index(),
            Person()
          ],
        ),
        bottomNavigationBar: _buildNavBar()
      ),
    );
  }

  Widget _buildNavBar() {
    return BottomNavigationBar(
      items: [
      _buildNavItem(Icons.home, '首页'),
      _buildNavItem(Icons.person, '我的')
    ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _pageIdx,
      onTap: (index) => _pageCtl.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String title) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(title));
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_jd/page/home_page.dart';
import 'package:flutter_jd/page/my_page.dart';
import 'package:flutter_jd/page/search_page.dart';
import 'package:flutter_jd/page/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('携程'), centerTitle: true, elevation: 0.0),
      body: PageView(
        controller: _controller,
        children: <Widget>[HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem(Icons.home, "首页", 0),
          _bottomItem(Icons.search, "搜索", 1),
          _bottomItem(Icons.camera_alt, "旅拍", 2),
          _bottomItem(Icons.camera_alt, "我的", 3),
        ],
      ),
    );
  }

  _bottomItem(IconData icon, String text, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          Icons.home,
          color: _activeColor,
        ),
        title: Text(
          text,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}

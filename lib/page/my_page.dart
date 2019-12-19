import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  ScrollController _controller = ScrollController();
  List<String> _city = [
    '北京',
    '上海',
    '深圳',
    '广州',
    '南宁',
    '江苏',
    '大连',
    '广州',
    '临沂',
    '青岛',
    '济南'
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的'),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: RefreshIndicator(
          child: ListView(controller: _controller, children: _buildList()),
          onRefresh: _handleRefresh,
        ));
  }

  List<Widget> _buildList() {
    return _city.map((item) => _item(item)).toList();
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      List<String> refreshList = _city.reversed.toList();
      _city = refreshList;
    });
  }

  _loadMore() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> item = List<String>.from(_city);
      item.addAll(_city);
      _city = item;
    });
  }

  Widget _item(String item) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.grey),
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        item,
        style: TextStyle(color: Colors.blue, fontSize: 20),
      ),
    );
  }
}

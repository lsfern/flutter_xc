import 'package:flutter/material.dart';
import 'package:flutter_jd/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: '哈哈',
            hint: '123',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
        ]));
  }

  @override
  void deactivate() {
    // 界面失去焦点关闭软键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onTextChange(String value) {}
}

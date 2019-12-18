import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('搜索'),
    );
  }
}

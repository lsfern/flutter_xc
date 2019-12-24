import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_jd/navigation/tabNavigator.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '携程app',
      home: TabNavigator(),
    );
  }
}

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('携程'),
      ),
      body: GestureDetector(
        child: Hero(
          tag: 'imgHero',
          child: Image.network('https://picsum.photos/250?image=9'),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondApp();
          }));
        },
      ),
    );
  }
}

class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero second App'),
      ),
      body: Center(
        child: GestureDetector(
          child: Hero(
              tag: 'imgHero',
              child: Image.network('https://picsum.photos/250?image=9')),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_jd/navigation/tabNavigator.dart';

void main() => runApp(MyApp());

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
        title: Text('Hero first app'),
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

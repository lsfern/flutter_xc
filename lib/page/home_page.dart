import 'package:flutter/material.dart';
import 'package:flutter_jd/dao/home_dao.dart';
import 'package:flutter_jd/model/banner_list_module.dart';
import 'package:flutter_jd/model/home_model.dart';
import 'package:flutter_jd/model/local_nav_list_module.dart';
import 'package:flutter_jd/widget/grid_nav.dart';
import 'package:flutter_jd/widget/swiper_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var resultString = "";
  double appBarAlpha = 0;
  List<BannerList> bannerlist = [];
  List<LocalNavList> localNavList = [];

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      HomeModel homeModel = await HomeDao.getHomeData();
      setState(() {
        localNavList = homeModel.localNavList;
        bannerlist = homeModel.bannerList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff2f2f2),
      body: Stack(
        children: <Widget>[_mainContent(), _appBar()],
      ),
    );
  }

  /// Set Content
  Widget _mainContent() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification &&
                  scrollNotification.depth == 0) {
                _onScroll(scrollNotification.metrics.pixels);
              }
              return false;
            },
            child: ListView(
              children: <Widget>[
                Container(height: 200, child: SpView(bannerList: bannerlist)),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(7, 4, 4, 7),
                  child: LocalNav(
                    localNavList: localNavList,
                  ),
                ),
                Container(
                  height: 800,
                  child: ListTile(
                    title: Text("q"),
                    subtitle: Text('This is HomePage subtitle'),
                    selected: true,
                    leading: Icon(
                      Icons.account_circle,
                      size: 20,
                    ),
                  ),
                )
              ],
            )));
  }

  /// Set AppBar
  Widget _appBar() {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }
}

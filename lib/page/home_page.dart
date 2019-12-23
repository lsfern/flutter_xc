import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jd/dao/home_dao.dart';
import 'package:flutter_jd/model/banner_list_module.dart';
import 'package:flutter_jd/model/config_module.dart';
import 'package:flutter_jd/model/grid_nav_module.dart';
import 'package:flutter_jd/model/home_model.dart';
import 'package:flutter_jd/model/local_nav_list_module.dart';
import 'package:flutter_jd/model/sale_box_module.dart';
import 'package:flutter_jd/page/search_page.dart';
import 'package:flutter_jd/utils/navigator_util.dart';
import 'package:flutter_jd/widget/grid_view.dart';
import 'package:flutter_jd/widget/loading_view.dart';
import 'package:flutter_jd/widget/local_nav.dart';
import 'package:flutter_jd/widget/sale_box.dart';
import 'package:flutter_jd/widget/search_bar.dart';
import 'package:flutter_jd/widget/sub_nav.dart';
import 'package:flutter_jd/widget/swiper_view.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_DEFAULT_TEXT = "网红打卡地 景点 酒店 美食";

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  // appBar透明度
  double appBarAlpha = 0;

  // 是否显示加载框
  bool isShowLoading = true;

  // 首页Banner
  List<BannerList> bannerList = [];

  // 首页LocalNav
  List<LocalNavList> localNavList = [];

  // 首页活动Nav
  List<LocalNavList> subNavList = [];

  // 首页GridNav
  GridNav gridNav;

  // 首页Box
  SalesBox salesBox;

  // 配置Module
  ConfigModule configModule;

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
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel homeModel = await HomeDao.getHomeData();
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        localNavList = homeModel.localNavList;
        bannerList = homeModel.bannerList;
        gridNav = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
        configModule = homeModel.config;
        isShowLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isShowLoading = false;
      });
    }
    return null;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffff2f2f2),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Stack(
            children: <Widget>[_mainContent, _appBar],
          ),
        ));
  }

  /// Set AppBar
  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Container(
              height: 80,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(
                      (appBarAlpha * 255).toInt(), 255, 255, 255)),
              child: SearchBar(
                searchBarType: appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                inputBoxClick: _jumpToSearch,
                speakClick: _jumpToSpeak,
                defaultText: SEARCH_DEFAULT_TEXT,
                leftButtonClick: () {},
              ),
            )),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  /// Set Content
  Widget get _mainContent {
    return LoadingView(
        isShowLoading: isShowLoading,
        child: MediaQuery.removePadding(
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
              child: _listView),
        ));
  }

  /// ListView
  Widget get _listView {
    return ListView(
      children: <Widget>[
        Container(height: 200, child: SpView(bannerList: bannerList)),
        Container(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: MyGridView(gridNav: gridNav),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SaleBoxView(salesBox: salesBox),
        ),
      ],
    );
  }

  /// 保持页面状态
  @override
  bool get wantKeepAlive => true;

  _jumpToSearch() {
    NavigatorUtil.push(
        context,
        SearchPage(
          hint: SEARCH_DEFAULT_TEXT,
          searchUrl: configModule.searchUrl,
        ));
  }

  _jumpToSpeak() {}
}

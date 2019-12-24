import 'package:flutter/material.dart';
import 'package:flutter_jd/dao/travel_dao.dart';
import 'package:flutter_jd/model/travel_model.dart';
import 'package:flutter_jd/model/travel_tab_model.dart';
import 'package:flutter_jd/widget/travele_gird_view.dart';

class TravelPage extends StatefulWidget {
  @override
  TravelState createState() => TravelState();
}

class TravelState extends State<TravelPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  List<TravelTabItem> tabs = [];
  TravelTabModule module;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    getTravelType();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<Null> getTravelType() async {
    var travelTabModule = await TravelDao.getTravelType();
    _controller =
        TabController(length: travelTabModule.tabs.length, vsync: this);
    setState(() {
      tabs = travelTabModule.tabs;
      module = travelTabModule;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: Color(0xff2fcfbb)),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTabItem item) {
                return Tab(
                  text: item.labelName,
                );
              }).toList(),
            ),
          ),
          Flexible(
              child: TabBarView(
            controller: _controller,
            children: tabs.map((TravelTabItem item) {
              return TravelGirdView(
                  travelUrl: module.url,
                  groupChannelCode: item.groupChannelCode);
            }).toList(),
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_jd/model/grid_nav_module.dart';
import 'package:flutter_jd/model/local_nav_list_module.dart';
import 'package:flutter_jd/widget/web_view.dart';

class MyGridView extends StatelessWidget {
  final GridNav gridNav;

  MyGridView({Key key, @required this.gridNav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> gridNavItems = [];
    if (gridNav == null) return gridNavItems;
    if (gridNav.hotel != null) {
      gridNavItems.add(_gridNavItem(context, gridNav.hotel, true));
    }
    if (gridNav.flight != null) {
      gridNavItems.add(_gridNavItem(context, gridNav.flight, false));
    }
    if (gridNav.travel != null) {
      gridNavItems.add(_gridNavItem(context, gridNav.travel, false));
    }
    return gridNavItems;
  }

  /// Render GridNav
  _gridNavItem(BuildContext context, GridNavItem item, isFirst) {
    Color startColor = Color(int.parse(('0xff' + item.startColor)));
    Color endColor = Color(int.parse(('0xff' + item.endColor)));
    List<Widget> items = [];
    items.add(_mainItems(context, item.mainItem));
    items.add(_doubleItems(context, item.item1, item.item2));
    items.add(_doubleItems(context, item.item3, item.item4));
    List<Widget> expandListItems = [];
    items.forEach((item) {
      expandListItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandListItems,
      ),
    );
  }

  /// Render MainItem
  _mainItems(BuildContext context, LocalNavList mainItem) {
    return _wrapItems(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.network(mainItem.icon,
                fit: BoxFit.contain,
                width: 88,
                height: 121,
                alignment: AlignmentDirectional.bottomEnd),
            Container(
                margin: EdgeInsets.only(top: 11),
                child: Text(
                  mainItem.title,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ))
          ],
        ),
        mainItem);
  }

  /// Left and Right Items
  _doubleItems(
      BuildContext context, LocalNavList topItems, LocalNavList bottomItems) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _items(context, topItems, true),
        ),
        Expanded(
          child: _items(context, bottomItems, false),
        )
      ],
    );
  }

  /// One Items
  _items(BuildContext context, LocalNavList item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 1, color: Colors.white);
    return _wrapItems(
        context,
        Container(
            decoration: BoxDecoration(
                border: Border(
                    left: borderSide,
                    bottom: isFirst ? borderSide : BorderSide.none)),
            child: Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )),
        item);
  }

  /// Click fun
  _wrapItems(BuildContext context, Widget widget, LocalNavList item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                  url: item.url,
                  statusBarColor: item.statusBarColor,
                  hideAppBar: item.hideAppBar,
                )));
      },
      child: widget,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/model/local_nav_list_module.dart';
import 'package:flutter_jd/model/sale_box_module.dart';
import 'package:flutter_jd/widget/web_view.dart';

class SaleBoxView extends StatelessWidget {
  final SalesBox salesBox;

  SaleBoxView({Key key, @required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (salesBox == null) return Container();
    return _items(context);
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return PhysicalModel(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(6),
      child: Column(
        children: <Widget>[
          Container(
              height: 44,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.network(
                    salesBox.icon,
                    fit: BoxFit.fill,
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebView(
                                  url: salesBox.moreUrl,
                                  statusBarColor: 'f0f0f0',
                                )));
                      },
                      child: Text('获取更多福利 >'),
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(0, 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(1, 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(2, 3),
          ),
        ],
      ),
    );
  }

  Widget _doubleItem(BuildContext context, LocalNavList leftModel,
      LocalNavList rightModel, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, leftModel, big, true, last),
        _item(context, rightModel, big, false, last)
      ],
    );
  }

  _item(BuildContext context, LocalNavList model, bool big, bool left,
      bool last) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          right: left
              ? BorderSide(width: 1, color: Color(0xfff2f2f2))
              : BorderSide.none,
          bottom: !last
              ? BorderSide(width: 1, color: Color(0xfff2f2f2))
              : BorderSide.none,
        )),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 8,
          height: big ? 129 : 80,
        ),
      ),
    );
  }
}

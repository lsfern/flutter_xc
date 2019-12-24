import 'package:flutter/material.dart';
import 'package:flutter_jd/dao/search_dao.dart';
import 'package:flutter_jd/model/search_module.dart';
import 'package:flutter_jd/utils/navigator_util.dart';
import 'package:flutter_jd/widget/search_bar.dart';
import 'package:flutter_jd/widget/web_view.dart';

const SEARCH_URL =
    "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=";
const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchPage extends StatefulWidget {
  final String searchUrl;
  final bool hideLeft;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key,
      this.searchUrl = SEARCH_URL,
      this.hideLeft = false,
      this.keyword,
      this.hint})
      : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchPage> {
  String keyword;
  SearchModule _searchModule;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        _appBar,
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: _searchModule?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position);
                  }),
            ))
      ],
    ));
  }

  /// AppBar
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
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  @override
  void deactivate() {
    // 界面失去焦点关闭软键盘
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 输入框内容改变回调
  void _onTextChange(String text) {
    if (text.length == 0) {
      setState(() {
        _searchModule = null;
      });
      return;
    }
    keyword = text;
    SearchDao.getData(widget.searchUrl, text).then((SearchModule module) {
      // 当module的keyword 和当前搜索的keyword相同时，进行渲染
      if (module.keyword == keyword) {
        setState(() {
          _searchModule = module;
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  Widget _item(int position) {
    if (_searchModule == null || _searchModule.data == null) return null;
    Data data = _searchModule.data[position];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebView(
              url: data.url,
              title: '详情',
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                width: 26,
                height: 26,
                image: AssetImage(_typeAssetsImage(data.type)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: _title(data),
                  ),
                  Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 5),
                      child: _subTitle(data))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _typeAssetsImage(String type) {
    if (type == null) return 'images/type_channelgroup.png';
    String path = "channelgroup";
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_${path}.png';
  }

  _title(Data item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, _searchModule.keyword));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.type ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(Data item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item.type ?? '',
          style: TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ' + (item.scoreDesc ?? ''),
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}

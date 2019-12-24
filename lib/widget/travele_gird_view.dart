import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/navigator_util.dart';
import 'package:flutter_jd/widget/loading_view.dart';
import 'package:flutter_jd/widget/web_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_jd/dao/travel_dao.dart';
import 'package:flutter_jd/model/travel_model.dart';

const PAGE_SIZE = 10;
const TRAVEL_URL =
    "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";

class TravelGirdView extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  const TravelGirdView(
      {Key key, this.travelUrl = TRAVEL_URL, this.groupChannelCode})
      : super(key: key);

  @override
  _TravelGirdViewState createState() => _TravelGirdViewState();
}

class _TravelGirdViewState extends State<TravelGirdView>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller = ScrollController();
  bool _isShowLoading = true;
  int pageIndex = 1;
  List<TravelModuleItem> data;

  @override
  void initState() {
    super.initState();
    getTravelData();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getTravelData(loadMore: true);
      }
    });
  }

  Future getTravelData({loadMore = false}) async {
    try {
      if (loadMore) {
        pageIndex++;
      } else {
        pageIndex = 1;
      }
      TravelModule module = await TravelDao.getTravelTabData(
          widget.travelUrl, widget.groupChannelCode, pageIndex, PAGE_SIZE);
      setState(() {
        _isShowLoading = false;
      });
      setState(() {
        List<TravelModuleItem> filterItems = _filterItems(module.resultList);
        if (data != null) {
          data.addAll(filterItems);
        } else {
          data = filterItems;
        }
      });
    } catch (e) {
      setState(() {
        _isShowLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
        isShowLoading: _isShowLoading,
        child: RefreshIndicator(
          onRefresh: getTravelData,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: StaggeredGridView.countBuilder(
                  controller: _controller,
                  crossAxisCount: 4,
                  itemCount: data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) =>
                      _TravelItems(index: index, data: data[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2))),
        ));
  }

  List<TravelModuleItem> _filterItems(List<TravelModuleItem> resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelModuleItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  @override
  bool get wantKeepAlive => true;
}

class _TravelItems extends StatelessWidget {
  final int index;
  final TravelModuleItem data;

  const _TravelItems({Key key, this.index, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebView(
              url: data.article.urls[0].h5Url,
              title: '详情',
            ));
      },
      child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: _cardView),
    );
  }

  Widget get _cardView {
    if (data?.article?.images[0]?.dynamicUrl == '' ?? '' == '') {
      return Container();
    }
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _itemImage(),
        Container(
          padding: EdgeInsets.fromLTRB(4, 4, 4, 6),
          child: Text(
            data.article.articleTitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _infoText()
      ],
    ));
  }

  _itemImage() {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network(
            data.article.images[0].dynamicUrl,
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.white,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: LimitedBox(
                          maxWidth: 130,
                          child: Text(
                            _itemTitle(data.article.articleTitle ?? ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _itemTitle(String title) {
    return data.article.pois == null || data.article.pois.length == 0
        ? '未知'
        : data.article.pois[0].poiName;
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_leftView(), _rightView()],
      ),
    );
  }

  _leftView() {
    return Row(
      children: <Widget>[
        PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            data.article.author?.coverImage?.dynamicUrl,
            width: 24,
            height: 24,
          ),
        ),
        Container(
          width: 90,
          padding: EdgeInsets.only(left: 5),
          child: Text(
            data.article?.author?.nickName ?? '',
            style: TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  _rightView() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.thumb_up,
          size: 14,
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            data.article?.likeCount?.toString() ?? '',
            style: TextStyle(fontSize: 10, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

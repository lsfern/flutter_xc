import 'package:flutter/material.dart';
import 'package:flutter_jd/model/banner_list_module.dart';
import 'package:flutter_jd/widget/web_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SpView extends StatelessWidget {
  final List<BannerList> bannerList;

  SpView({Key key, @required this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebView(
                      url: bannerList[index].url,
                      statusBarColor: 'f0f0f0',
                    )));
          },
          child: Image.network(
            bannerList[index].icon,
            fit: BoxFit.cover,
          ),
        );
      },
      pagination: SwiperPagination(),
    );
  }
}

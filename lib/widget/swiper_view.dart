import 'package:flutter/material.dart';
import 'package:flutter_jd/model/banner_list_module.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SpView extends StatelessWidget {
  List<BannerList> bannerList;

  SpView({Key key, @required this.bannerList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<String> _imgList = [
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/zhuyilong2.jpg",
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/zhouzhennan2.jpg",
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/yangzi2.jpg",
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/yangmi2.jpg",
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/yangchaoyue2.jpg",
    "https://secondschased.oss-cn-beijing.aliyuncs.com/AboutStarInfomation/xiaozhan2.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imgList.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _imgList[index],
                    fit: BoxFit.cover,
                  );
                },
                pagination: SwiperPagination(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

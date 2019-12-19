import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_jd/model/home_model.dart';

class HomeDao {
  static final String homeUrl =
      "http://www.devio.org/io/flutter_app/json/home_page.json";
  /// 首页大接口
  static Future<HomeModel> getHomeData() async {
    final response = await http.get(homeUrl);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('get home data error');
    }
  }
}

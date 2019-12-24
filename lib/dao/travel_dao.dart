import 'dart:async';
import 'dart:convert';
import 'package:flutter_jd/model/travel_model.dart';
import 'package:flutter_jd/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_TYPE_YRL =
    "http://www.devio.org/io/flutter_app/json/travel_page.json";
var params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {'cid': "09031014111431397988"},
  "contentType": "json"
};

class TravelDao {
  /// 获取旅拍类别
  static Future<TravelTabModule> getTravelType() async {
    final response = await http.get(TRAVEL_TYPE_YRL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModule.fromJson(result);
    } else {
      throw Exception('get travel type error');
    }
  }

  /// 获取旅拍Tab对应的数据
  static Future<TravelModule> getTravelTabData(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    params['groupChannelCode'] = groupChannelCode;
    final response = await http.post(url, body: jsonEncode(params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return TravelModule.fromJson(result);
    } else {
      throw Exception('get travel tab data error');
    }
  }
}

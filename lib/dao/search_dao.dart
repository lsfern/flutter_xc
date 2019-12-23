import 'dart:convert';

import 'package:flutter_jd/model/search_module.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  /// 获取搜索数据
  static Future<SearchModule> getData(String url, String keyword) async {
    var response = await http.get(url + keyword);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      // module 动态添加keyword，增强搜索流畅性
      SearchModule module = SearchModule.fromJson(result);
      module.keyword = keyword;
      return module;
    } else {
      throw Exception('get search data error');
    }
  }
}

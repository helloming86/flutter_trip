import 'package:trip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip/model/search_model.dart';

class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final response = await http.get(url);
     if(response.statusCode == 200) {
       Utf8Decoder utf8decoder = Utf8Decoder(); // 消除中文乱码
       var result = json.decode(utf8decoder.convert(response.bodyBytes)); // json.decode()将返回的json字符串进行解码
       return SearchModel.fromJson(result);
     } else {
       throw Exception('Fail to load searchPage json');
     }
  }
}
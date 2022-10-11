import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class YacineAPI {
  final String apiUrl = 'http://ver3.yacinelive.com';
  final String apiKey = 'c!xZj+N9&G@Ev@vw';
  List<dynamic> _decrypt(String enc, String key) {
    var a = const AsciiDecoder().convert(
        base64Decode(String.fromCharCodes(const AsciiEncoder().convert(enc))));
    var result = '';
    for (var i = 0; i < a.length; i++) {
      result = result +
          String.fromCharCode(
              a[i].codeUnits[0] ^ key[i % key.length].codeUnits[0]);
    }
    var jsonFile = json.decode(result)['data'];
    print(jsonFile);
    return jsonFile;
  }

  Future<List<dynamic>?> _request(String endpoint) async {
    try {
      var url = Uri.parse(apiUrl + endpoint);
      var response = await get(url);
      return _decrypt(response.body, apiKey + response.headers['t']!);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<dynamic>?> getCategories() async {
    return await _request('/api/categories');
  }

  Future<List<dynamic>?> getCategory(int categoryId) {
    return _request('/api/categories/$categoryId)');
  }

  Future<List<dynamic>?> getCategoryChannels(int categoryId) {
    return _request('/api/categories/$categoryId/channels');
  }

  Future<List<dynamic>?> getChannel(int channelId) {
    return _request('/api/channel/$channelId');
  }
}

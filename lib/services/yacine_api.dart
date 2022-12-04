import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yacine_tv/ui/models/models.dart';

class YacineAPI {
  final String apiUrl = 'https://ver3.yacinelive.com';
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
    return jsonFile;
  }

  Future<List<dynamic>?> _request(String endpoint) async {
    try {
      var url = Uri.parse(apiUrl + endpoint);
      var response = await get(url);
      return _decrypt(response.body, apiKey + response.headers['t']!);
    } catch (e) {
      return [
        {'error': e.toString()}
      ];
    }
  }

  Future<List<dynamic>?> getCategory(String categoryId) {
    return _request(
        categoryId != "" ? '/api/categories/$categoryId' : '/api/categories');
  }

  Future<List<dynamic>?> getCategoryChannels(int categoryId) {
    return _request('/api/categories/$categoryId/channels');
  }

  Future<List<dynamic>?> getChannel(int channelId) {
    return _request('/api/channel/$channelId');
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:chuck_norris/core/ApiResponse.dart';
import 'package:chuck_norris/data/repository.dart';
import 'package:chuck_norris/models/joke.dart';
import 'package:http/http.dart' as http;

class ApiSourceImpl implements ApiSource {

  String url;

  ApiSourceImpl(this.url);

  @override
  Future<ApiResponse> getJokes() async {
    late Joke joke;
    try {
      var response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        joke = Joke.fromJson(json);
        return ApiResponse(joke);
      } else {
        return ApiResponse(null, errorMsg: 'Error ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString(), name: 'getJokes ApiSourceImpl');
      return ApiResponse(null, errorMsg: e.toString());
    }
  }

}
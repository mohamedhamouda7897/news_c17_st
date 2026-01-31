import 'package:dio/dio.dart';
import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';

import 'constants.dart';

class ApiManager {
  static final dio = Dio();

  static Future<SourcesResponse?> getSources() async {
    try {
      Response response = await dio.get(
        "$BASEURL/v2/top-headlines/sources?apiKey=$APIKEY",
      );

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

      return sourcesResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  static Future<NewsResponse?> getNewsData(String sourceId) async {
    try {
      Response response = await dio.get(
        "$BASEURL/v2/everything?sources=$sourceId&apiKey=$APIKEY",
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      return newsResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}

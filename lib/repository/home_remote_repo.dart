import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_c17_st/core/api_manager.dart';
import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';
import 'package:news_c17_st/repository/home_repo.dart';


@Injectable(as: HomeRepo)
class HomeRemoteRepo extends HomeRepo {
  ApiManager apiManager;

  HomeRemoteRepo(this.apiManager);

  @override
  Future<NewsResponse> getNewsData(String sourceId) async {
    try {
      Response response = await apiManager.get(
        "/v2/everything",
        queryParameters: {"sources": sourceId},

      );

      return NewsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<SourcesResponse> getSources(String catId) async {
    try {
      Response response = await apiManager.get(
        "/v2/top-headlines/sources?category=$catId",
      );

      return SourcesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception();
    }
  }
}

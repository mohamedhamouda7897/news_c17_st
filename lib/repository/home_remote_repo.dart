import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';
import 'package:news_c17_st/repository/home_repo.dart';

class HomeRemoteRepo implements HomeRepo{
  @override
  Future<NewsResponse> getNewsData(String sourceId) {
    // TODO: implement getNewsData
    throw UnimplementedError();
  }

  @override
  Future<SourcesResponse> getSources(String catId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
  
}
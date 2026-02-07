import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';


abstract class HomeRepo {
  Future<SourcesResponse> getSources(String catId);

  Future<NewsResponse> getNewsData(String sourceId);
}




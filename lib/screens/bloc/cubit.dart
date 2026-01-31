import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';
import 'package:news_c17_st/screens/bloc/states.dart';

import '../../core/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Dio dio = Dio();

  int selectedIndex = 0;
  List<Sources> sources = [];
  List<Articles> articles = [];

  onTabChanges(int index) {
    selectedIndex = index;
    emit(HomeOnTabChanged());
    getNewsData(sources[selectedIndex].id ?? "");

  }

  Future<void> getNewsData(String sourceId) async {
    emit(GetNewsLoadingState());
    try {
      Response response = await dio.get(
        "$BASEURL/v2/everything?sources=$sourceId&apiKey=$APIKEY",
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      articles = newsResponse.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      Response response = await dio.get(
        "$BASEURL/v2/top-headlines/sources?apiKey=$APIKEY",
      );

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

      sources = sourcesResponse.sources ?? [];

      emit(GetSourcesSuccessState());
      getNewsData(sources[selectedIndex].id ?? "");
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}

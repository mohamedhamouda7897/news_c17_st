import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c17_st/core/dio_interceptor.dart';
import 'package:news_c17_st/models/news_response.dart';
import 'package:news_c17_st/models/sources_response.dart';
import 'package:news_c17_st/repository/home_repo.dart';
import 'package:news_c17_st/screens/bloc/states.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/constants.dart';
import '../../core/constants.dart' as AppConstants;

class HomeCubit extends Cubit<HomeStates> {
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitState()) {
    dio.interceptors.add(PrettyDioLogger(request: true, responseBody: true));
    dio.interceptors.add(MyInterceptor());
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASEURL,
      headers: {
        // "x-api-key" : AppConstants.APIKEY,
      },
    ),
  );

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
      NewsResponse newsResponse = await repo.getNewsData(sourceId);

      articles = newsResponse.articles ?? [];
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      SourcesResponse sourcesResponse = await repo.getSources(categoryId);
      sources = sourcesResponse.sources ?? [];

      emit(GetSourcesSuccessState());
      getNewsData(sources[selectedIndex].id ?? "");
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}

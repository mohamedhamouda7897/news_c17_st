import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_c17_st/core/api_manager.dart';
import 'package:news_c17_st/screens/bloc/cubit.dart';
import 'package:news_c17_st/screens/bloc/states.dart';
import 'package:news_c17_st/screens/widgets/aritcle_item.dart';

class NewsData extends StatelessWidget {
  const NewsData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetNewsLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: HomeCubit.get(context).articles.length ?? 0,
          itemBuilder: (context, index) {
            return ArticleItem(article: HomeCubit.get(context).articles[index]);
          },
        );
      },
    );
  }
}

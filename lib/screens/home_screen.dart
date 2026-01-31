import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_c17_st/core/api_manager.dart';
import 'package:news_c17_st/screens/bloc/cubit.dart';
import 'package:news_c17_st/screens/bloc/states.dart';
import 'package:news_c17_st/screens/news_data.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("News App")),
        body: BlocProvider(
          create: (context) => HomeCubit()..getSources(),

          child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is GetSourcesLoadingState) {
                context.loaderOverlay.show();
              }else{
                context.loaderOverlay.hide();
              }
            },
            builder: (context, state) {
              // var cubit = BlocProvider.of<HomeCubit>(context);

              return Column(
                children: [
                  DefaultTabController(
                    length: HomeCubit.get(context).sources.length,
                    initialIndex: HomeCubit.get(context).selectedIndex,
                    child: TabBar(
                      isScrollable: true,
                      onTap: (value) {
                        HomeCubit.get(context).onTabChanges(value);
                      },
                      dividerColor: Colors.transparent,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: const Color(0xFF1C1C1C),
                      unselectedLabelColor: Color(0xFF1C1C1C),
                      indicatorColor: Color(0xFF1C1C1C),
                      padding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      tabs:
                          HomeCubit.get(context).sources
                              .map((e) => Tab(child: Text(e.name ?? "")))
                              .toList() ??
                          [],
                    ),
                  ),
                  Expanded(child: NewsData()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_st/core/api_manager.dart';
import 'package:news_c17_st/screens/news_data.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News App")),
      body: FutureBuilder(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          } else {
            var sourcesResponse = snapshot.data;

            return Column(
              children: [
                DefaultTabController(
                  length: sourcesResponse?.sources?.length ?? 0,
                  initialIndex: selectedIndex,
                  child: TabBar(
                    isScrollable: true,
                    onTap: (value) {
                      selectedIndex = value;
                      setState(() {});
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
                    sourcesResponse?.sources
                            ?.map((e) => Tab(child: Text(e.name ?? "")))
                            .toList() ??
                        [],
                  ),
                ),
                Expanded(
                  child: NewsData(
                    sourceId: sourcesResponse?.sources?[selectedIndex].id ?? "",
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

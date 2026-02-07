import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_c17_st/core/api_manager.dart';
import 'package:news_c17_st/models/category_model.dart';
import 'package:news_c17_st/screens/bloc/cubit.dart';
import 'package:news_c17_st/screens/bloc/states.dart';
import 'package:news_c17_st/screens/news_data.dart';
import 'package:news_c17_st/screens/views/app_drawer.dart';
import 'package:news_c17_st/screens/views/categories_view.dart';
import 'package:news_c17_st/screens/views/sources_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        drawer: AppDrawer(onDrawerClicked: onDrawerClicked),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.label,
          ),
        ),
        body: selectedCategory == null
            ? CategoriesView(onCategoryClicked: onCategoryClicked)
            : SourcesView(catId: selectedCategory!.id),
      ),
    );
  }

  CategoryModel? selectedCategory;

  onDrawerClicked() {
    selectedCategory = null;
    setState(() {});
    Navigator.pop(context);
  }

  onCategoryClicked(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }
}

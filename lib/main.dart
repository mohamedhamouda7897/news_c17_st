import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c17_st/core/theme/bloc/cubit.dart';
import 'package:news_c17_st/core/theme/bloc/states.dart';
import 'package:news_c17_st/di.dart' show configureDependencies;
import 'package:news_c17_st/screens/home_screen.dart';

import 'core/internetchecker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  InternetConnectivity().initialize();

  configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (context, state) {
          return  MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {HomeScreen.routeName: (context) => HomeScreen()},
    );
  }
}

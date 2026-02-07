import 'package:flutter/material.dart';
import 'package:news_c17_st/screens/home_screen.dart';

import 'core/internetchecker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InternetChecker().initialize();
  runApp(const MyApp());
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

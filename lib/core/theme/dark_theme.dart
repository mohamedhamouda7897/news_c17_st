import 'package:flutter/material.dart';

import 'base_theme.dart';

class DarkTheme extends BaseColors {
  @override
  Color get background => Colors.black;

  @override
  Color get error => Colors.red;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => Colors.white;

  @override
  Color get surface => Colors.blue.shade50;
}

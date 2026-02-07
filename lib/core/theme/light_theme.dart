import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_c17_st/core/theme/base_theme.dart';

class LightTheme extends BaseColors {
  @override
  Color get background => Color(0xFFFFFFFF);

  @override
  Color get error => Colors.red;

  @override
  Color get primary => Colors.white;

  @override
  Color get secondary => Colors.black;

  @override
  Color get surface => Colors.grey;
}

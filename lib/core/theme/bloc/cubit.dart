import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c17_st/core/theme/base_theme.dart';
import 'package:news_c17_st/core/theme/bloc/states.dart';
import 'package:news_c17_st/core/theme/dark_theme.dart';
import 'package:news_c17_st/core/theme/light_theme.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  BaseColors baseColors = LightTheme();

  changeTheme() {
    emit(ThemeInitState());
    if (baseColors is LightTheme) {
      baseColors = DarkTheme();
    } else {
      baseColors = LightTheme();
    }

    emit(ThemeChangedState());
  }
}

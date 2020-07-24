import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:passline_mobile/theme/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: AppTheme.Light, themeData: appThemeData[AppTheme.Light]));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeStarted) {
      yield* _mapStartedToState(event);
    }
    if (event is ThemeChanged) {
      yield* _mapChangedToState(event);
    }
  }

  Stream<ThemeState> _mapChangedToState(ThemeChanged event) async* {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    sPrefs.setString("theme", event.theme.toString());
    yield ThemeState(theme: event.theme, themeData: appThemeData[event.theme]);
  }

  Stream<ThemeState> _mapStartedToState(ThemeStarted event) async* {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    var themeString = sPrefs.get("theme");
    if (themeString != null) {
      AppTheme theme = AppTheme.values.firstWhere((e) => e.toString() == themeString);
      yield ThemeState(theme: theme, themeData: appThemeData[theme]);
    } else {
      yield ThemeState(theme: AppTheme.Light, themeData: appThemeData[AppTheme.Light]);
    }
  }
}
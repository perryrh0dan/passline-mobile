import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/theme/app_themes.dart';
import 'package:passline/theme/bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onThemeSwitchToggle(bool value) {
      BlocProvider.of<ThemeBloc>(context).add(
        value ? ThemeChanged(theme: AppTheme.Dark) : ThemeChanged(theme: AppTheme.Light)
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<ThemeBloc>(context),
        builder: (context, ThemeState state) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Switch(value: state.theme == AppTheme.Light ? false : true, onChanged: _onThemeSwitchToggle)
              ],
            ),
          );
        },
        ),
    );
  }
}

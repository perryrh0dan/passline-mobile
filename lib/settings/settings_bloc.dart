import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class Settings {
  Settings(); 
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>{

  SettingsBloc() : super(SettingsLoading());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettings) {
      yield* _mapLoadToState(event);
    }
    if (event is SaveSettings) {
      yield* _mapSaveToState(event);
    }
  }

  Stream<SettingsState> _mapLoadToState(LoadSettings event) async* {
      yield SettingsLoading();
      SharedPreferences sPrefs = await SharedPreferences.getInstance();
      Settings settings = new Settings();
      yield SettingsLoaded(settings: settings);
  }

  Stream<SettingsState> _mapSaveToState(SaveSettings event) async* {
      yield SettingsSaving();
      SharedPreferences sPrefs = await SharedPreferences.getInstance();
      yield SettingsLoaded(settings: event.settings);
  } 
}

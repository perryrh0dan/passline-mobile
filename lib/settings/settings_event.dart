part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class SaveSettings extends SettingsEvent {
  final Settings settings;

  SaveSettings({@required this.settings});

  @override
  List<Object> get props => [this.settings];
}

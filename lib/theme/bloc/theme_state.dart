part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final AppTheme theme;
  final ThemeData themeData;

  const ThemeState({@required this.theme, @required this.themeData});

  @override
  List<Object> get props => [themeData];
}

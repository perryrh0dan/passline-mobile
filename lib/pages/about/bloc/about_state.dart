part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final PackageInfo packageInfo;

  const AboutLoaded({@required this.packageInfo});
}

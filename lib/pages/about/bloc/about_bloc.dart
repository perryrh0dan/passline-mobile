import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc();

  @override
  AboutState get initialState => AboutLoading();

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    if (event is AboutStarted) {
      yield* _mapStartedToState();
    }
  }

  Stream<AboutState> _mapStartedToState() async* {
    yield AboutLoading();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    yield AboutLoaded(packageInfo: packageInfo);
  }
}
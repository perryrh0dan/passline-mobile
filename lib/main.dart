import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/authentication/authentication_bloc.dart';
import 'package:passline_mobile/common/common.dart';
import 'package:passline_mobile/pages/home/home_page.dart';
import 'package:passline_mobile/pages/login/login_page.dart';
import 'package:passline_mobile/pages/registration/registration_page.dart';
import 'package:passline_mobile/settings/settings_bloc.dart';
import 'package:passline_mobile/theme/bloc/theme_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocDelegate();

  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) {
        return ThemeBloc()..add(ThemeStarted());
      },
      child: Passline(),
    );
  }
}

class Passline extends StatelessWidget {
  final options = FirebaseOptions(
    apiKey: "AIzaSyBCVckhzRrmyskxsRIHv7M9e7zOvt53N6c",
    appId: "1:386145949994:android:5ce085e3a3225e6922e653",
    messagingSenderId: 'passline-mobile',
    projectId: "paine-3ab6f",
  );

  Passline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          builder: (context, widget) {
            return FutureBuilder(
              future: Firebase.initializeApp(options: options),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final userRepository = FirebaseUserRepository();
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<AuthenticationBloc>(
                        create: (context) =>
                            AuthenticationBloc(userRepository: userRepository)
                              ..add(
                                AuthenticationStarted(),
                              ),
                      ),
                      BlocProvider<SettingsBloc>(
                        create: (context) => SettingsBloc()
                          ..add(
                            LoadSettings(),
                          ),
                      ),
                    ],
                    child: widget,
                  );
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Scaffold(
                  body: LoadingIndicator(),
                );
              },
            );
          },
          title: 'Passline',
          theme: state.themeData,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return HomePage(
                  userRepository: FirebaseUserRepository(),
                );
              } else if (state is Registered) {
                return LoginPage(
                  userRepository: FirebaseUserRepository(),
                );
              } else if (state is NotRegistered) {
                return RegistrationPage(
                  userRepository: FirebaseUserRepository(),
                );
              } else {
                return Scaffold(
                  body: LoadingIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}

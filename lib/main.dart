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
  final userRepository = FirebaseUserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(userRepository: userRepository)
              ..add(AuthenticationStarted());
          },
        ),
        BlocProvider<ThemeBloc>(
          create: (context) {
            return ThemeBloc()..add(ThemeStarted());
          },
        ),
        BlocProvider<SettingsBloc>(
          create: (context) {
            return SettingsBloc()..add(LoadSettings());
          },
        )
      ],
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return _buildWithTheme(context, state);
    });
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Passline',
      theme: state.themeData,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return _buildWithAuthentication(context, state);
        },
      ),
    );
  }

  Widget _buildWithAuthentication(
      BuildContext context, AuthenticationState state) {
    if (state is Authenticated) {
      return HomePage(
        userRepository: userRepository,
      );
    } else if (state is Registered) {
      return LoginPage(
        userRepository: userRepository,
      );
    } else if (state is NotRegistered) {
      return RegistrationPage(
        userRepository: userRepository,
      );
    } else {
      return Scaffold(
        body: LoadingIndicator(),
      );
    }
  }
}

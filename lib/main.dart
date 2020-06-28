import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/common/common.dart';
import 'package:passline/pages/home/home_page.dart';
import 'package:passline/pages/login/login_page.dart';
import 'package:passline/pages/registration/registration_page.dart';
import 'package:passline/pages/setup/setup.dart';
import 'package:passline/theme/bloc/theme_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SimpleBlocDelegate extends BlocDelegate {
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
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
            return ThemeBloc();
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
      return FutureBuilder(
        future: this.userRepository.hasKey(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          } else if (snapshot.data) {
            return HomePage();
          } else {
            return SetupPage(userRepository: userRepository);
          }
        },
      );
    } else if (state is Registered) {
      return LoginPage(userRepository: userRepository);
    } else if (state is NotRegistered) {
      return RegistrationPage(userRepository: userRepository);
    } else {
      return LoadingIndicator();
    }
  }
}

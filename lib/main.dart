import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/authentication/authentication_bloc.dart';
import 'package:passline/pages/home/home_page.dart';
import 'package:passline/pages/login/login_page.dart';
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

class App extends StatefulWidget {
  final UserRepository userRepository;

  const App({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
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
      return HomePage();
    }
    return LoginPage(userRepository: widget.userRepository);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {
      context.bloc<AuthenticationBloc>().add(AuthenticationLocked());
    } else if (state == AppLifecycleState.paused) {
      context.bloc<AuthenticationBloc>().add(AuthenticationLocked());
    } else if (state == AppLifecycleState.detached) {
      print("detached");
    }
  }
}

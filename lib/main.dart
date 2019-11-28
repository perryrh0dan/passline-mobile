import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/blocs/bloc.dart';
import 'package:passline/screens/screens.dart';
import 'package:items_repository/items_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            builder: (context) {
              return AuthenticationBloc(
                userRepository: FirebaseUserRepository(),
              )..add(AppStarted());
            },
          ),
          BlocProvider<ItemsBloc>(
            builder: (context) {
              return ItemsBloc(
                itemsRepository: FirebaseItemsRepository(),
              )..add(LoadItems());
            },
          ),
        ],
        child: MaterialApp(
          title: 'Passline',
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return HomeScreen();
                  }
                  if (state is Unauthenticated) {
                    return Center(
                      child: Text('Could not authenticate with Firestore'),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          },
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline_mobile/pages/contributers/bloc/contributers_bloc.dart';
import 'package:passline_mobile/pages/contributers/contributers_form.dart';

class ContributersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contributers"),
      ),
      body: BlocProvider(
        create: (context) {
          return ContributersBloc()..add(ContributersLoad());
        },
        child: ContributersForm(),
      ),
    );
  }
}
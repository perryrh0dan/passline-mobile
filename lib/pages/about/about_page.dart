import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passline/common/common.dart';
import 'package:passline/pages/about/bloc/about_bloc.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onContributersClick() {}

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: BlocProvider(
        create: (context) => AboutBloc()
          ..add(
            AboutStarted(),
          ),
        child: Builder(builder: (context) {
          return BlocBuilder(
            bloc: BlocProvider.of<AboutBloc>(context),
            builder: (BuildContext context, AboutState state) {
              if (state is AboutLoaded) {
                return ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text("Name"),
                      subtitle: Text(state.packageInfo.appName),
                    ),
                    ListTile(
                      title: Text("Version"),
                      subtitle: Text(state.packageInfo.version),
                    ),
                    ListTile(
                      title: Text("Github"),
                      subtitle: Text(
                          "https://github.com/perryrh0dan/passline-mobile"),
                    ),
                    ListTile(
                        title: Text("Developer"),
                        subtitle: Text("Thomas Pöhlmann")),
                    ListTile(
                      title: Text("Contributers"),
                      onTap: _onContributersClick,
                    )
                  ],
                );
              }
              return LoadingIndicator();
            },
          );
        }),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:passline_mobile/pages/contributers/contributer.dart';

part 'contributers_event.dart';
part 'contributers_state.dart';

class ContributersBloc extends Bloc<ContributersEvent, ContributersState> {
  ContributersBloc() : super(ContributersLoading());

  @override
  Stream<ContributersState> mapEventToState(
    ContributersEvent event,
  ) async* {
    if (event is ContributersLoad) {
      yield* _mapLoadingToState();
    }
  }

  Stream<ContributersState> _mapLoadingToState() async* {
    yield ContributersLoading();
    var response = await http.get("https://api.github.com/repos/perryrh0dan/passline-mobile/contributors");
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Contributer> contributers = new List<Contributer>();
      l.forEach((element) {
        var contributer = Contributer.fromJson(element);
        contributers.add(contributer);
      });
      yield ContributersLoaded(contributers: contributers);
    } else {
      yield ContributersFailure(error: response.statusCode.toString());
    }
  }
}

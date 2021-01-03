part of 'addEdit_bloc.dart';

abstract class AddEditEvent extends Equatable {
  const AddEditEvent();

  @override
  List<Object> get props => [];
}

class PasswordLengthChanged extends AddEditEvent {
  const PasswordLengthChanged({@required this.length});

  final int length;

  @override
  List<Object> get props => [length];
}

class CharactersSetChanged extends AddEditEvent {
  const CharactersSetChanged({@required this.characters});

  final bool characters;

  @override
  List<Object> get props => [characters];
}

class NumbersSetChanged extends AddEditEvent {
  const NumbersSetChanged({@required this.numbers});

  final bool numbers;

  @override
  List<Object> get props => [numbers];
}

class SymbolsSetChanged extends AddEditEvent {
  const SymbolsSetChanged({@required this.symbols});

  final bool symbols;

  @override
  List<Object> get props => [symbols];
}

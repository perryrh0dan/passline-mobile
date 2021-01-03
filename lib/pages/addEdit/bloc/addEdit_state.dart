part of 'addEdit_bloc.dart';

class AddEditState extends Equatable {
  const AddEditState(
      {this.length, this.characters, this.numbers, this.symbols});

  final int length;
  final bool characters;
  final bool numbers;
  final bool symbols;

  AddEditState copyWith({
    int length,
    bool characters,
    bool numbers,
    bool symbols,
  }) {
    return AddEditState(
      length: length ?? this.length,
      characters: characters ?? this.characters,
      numbers: numbers ?? this.numbers,
      symbols: symbols ?? this.symbols,
    );
  }

  @override
  List<Object> get props => [length, characters, numbers, symbols];
}

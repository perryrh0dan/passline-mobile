part of 'addEdit_bloc.dart';

class AddEditState extends Equatable {
  AddEditState({
    this.name = "",
    this.username = "",
    this.length = 20,
    this.characters = true,
    this.numbers = true,
    this.symbols = true,
    this.password = "",
  });

  final String name;
  final String username;
  final int length;
  final bool characters;
  final bool numbers;
  final bool symbols;
  final String password;

  AddEditState copyWith({
    String name,
    String username,
    int length,
    bool characters,
    bool numbers,
    bool symbols,
  }) {
    var newLength = length ?? this.length;
    var newCharacters = characters ?? this.characters;
    var newNumbers = numbers ?? this.numbers;
    var newSymbols = symbols ?? this.symbols;
    var newPassword = this.password;

    if (length != null ||
        characters != null ||
        numbers != null ||
        symbols != null) {
      newPassword =
          PwGen.generate(newLength, newSymbols, newNumbers, newCharacters);
    }

    return AddEditState(
      name: name ?? this.name,
      username: username ?? this.username,
      length: newLength,
      characters: newCharacters,
      numbers: newNumbers,
      symbols: newSymbols,
      password: newPassword,
    );
  }

  @override
  List<Object> get props =>
      [name, username, length, characters, numbers, symbols, password];
}

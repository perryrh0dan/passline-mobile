import 'dart:math';

class PwGen {
  static String generate(int length, bool symb, bool numb, bool charac) {
    List<String> lowercase = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    ];
    List<String> uppercase = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z"
    ];
    List<String> numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    List<String> symbols = ["!", "\$", "%", "&", "(", ")", "/", "?"];

    List<String> all = List<String>();

    int offset = 4;
    if (charac) {
      all.addAll(lowercase);
      all.addAll(uppercase);
    } else {
      offset--;
    }
    if (numb) {
      all.addAll(numbers);
    } else {
      offset--;
    }
    if (symb) {
      all.addAll(symbols);
    } else {
      offset--;
    }

    Random rnd = Random();

    List<String> a = List<String>();

    // get the requirements
    if (charac) {
      a.add(lowercase[rnd.nextInt(lowercase.length - 1)]);
      a.add(uppercase[rnd.nextInt(uppercase.length - 1)]);
    }
    if (numb) {
      a.add(numbers[rnd.nextInt(numbers.length - 1)]);
    }
    if (symb) {
      a.add(symbols[rnd.nextInt(symbols.length - 1)]);
    }

    // populate the rest with random chars
    for (var i = 0; i < length - offset; i++) {
      a.add(all[rnd.nextInt(all.length - 1)]);
    }

    // shuffel up
    for (var i = 0; i < a.length; i++) {
      int randomPosition = rnd.nextInt(a.length - 1);
      String temp = a[i];
      a[i] = a[randomPosition];
      a[randomPosition] = temp;
    }

    String password = a.join("");
    return password;
  }
}

class Validators {
  static final RegExp _alphaReg = RegExp(r'^[A-Za-z]+$');

  static bool isAlphabetic(String input) {
    return _alphaReg.hasMatch(input);
  }

  static String normalize(String s) => s.trim().toLowerCase();
}

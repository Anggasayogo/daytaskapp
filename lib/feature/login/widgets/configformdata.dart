class ConfigFormData {
  String chars = 'abdefghnryABDEFGHNQRY3468';
  int length = 6;
  double fontSize = 0;
  bool caseSensitive = false;
  Duration codeExpireAfter = const Duration(minutes: 10);

  @override
  String toString() {
    return '$chars$length$caseSensitive${codeExpireAfter.inMinutes}';
  }
}
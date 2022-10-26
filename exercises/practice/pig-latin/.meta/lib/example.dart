String translate(String phrase) {
  if (phrase.trim().isEmpty) {
    return "";
  }

  return phrase.split(' ').map(_translateCapitalizedWord).join(' ');
}

String _translateCapitalizedWord(String word) {
  final translation = _translateWord(word);

  return _isCapitalized(word) ? _capitalize(translation) : translation;
}

String _translateWord(String word) {
  final isAllCaps = _isAllUpperCase(word);
  final ay = isAllCaps ? "AY" : "ay";
  final quay = isAllCaps ? "QUAY" : "quay";

  if (_wordStartsWithVowelLike(word)) {
    return word + ay;
  }

  if (_wordStartsWithPrefixes(word, ["thr", "sch"])) {
    return word.substring(3) + word.substring(0, 3) + ay;
  }

  if (_wordStartsWithPrefixes(word, ["ch", "qu", "th", "rh"])) {
    return word.substring(2) + word.substring(0, 2) + ay;
  }

  if (_wordStartsWithConsonantAndQu(word)) {
    return word.substring(3) + word[0] + quay;
  }

  return word.substring(1) + word[0] + ay;
}

String _capitalize(String word) {
  return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
}

bool _isCapitalized(String word) {
  return RegExp(r'^[A-Z][a-z]+$').hasMatch(word);
}

bool _isAllUpperCase(String word) {
  return word == word.toUpperCase();
}

bool _wordStartsWithVowelLike(String word) {
  return RegExp(r'^([aeiou]|yt|xr)', caseSensitive: false).hasMatch(word);
}

bool _wordStartsWithPrefixes(String word, List<String> prefixes) {
  return prefixes.any(
    (prefix) => word.startsWith(RegExp(prefix, caseSensitive: false)),
  );
}

bool _wordStartsWithConsonantAndQu(String word) {
  return RegExp(
    r'[bcdfghjklmnpqrstvwxyz]qu',
    caseSensitive: false,
  ).hasMatch(word);
}

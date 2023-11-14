import 'dart:math';

String generateRandomId() {
  final random = Random();
  final letters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];
  final numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  var id = '';
  for (var i = 0; i < 10; i++) {
    final letter = letters[random.nextInt(letters.length)];
    final number = numbers[random.nextInt(numbers.length)];
    id += '$letter$number';
  }
  return id;
}

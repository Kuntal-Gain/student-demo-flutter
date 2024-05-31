import 'dart:math';

String generateId() {
  int randomNumber = Random().nextInt(90000) + 10000;

  String id = 'S$randomNumber';

  return id;
}

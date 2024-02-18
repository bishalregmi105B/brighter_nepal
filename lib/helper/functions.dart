import 'dart:convert';
import 'dart:math';

String generateOrderNumber() {
  String today =
      DateTime.now().toLocal().toString().split(' ')[0].replaceAll('-', '');
  String rand = _generateRandomString();
  String orderNumber = today + rand;
  return orderNumber;
}

String _generateRandomString() {
  String uniqueId = sha1(DateTime.now().millisecondsSinceEpoch.toString());
  String rand = uniqueId.substring(0, 4).toUpperCase();
  return rand;
}

String sha1(String input) {
  // Replace this with a proper implementation of SHA-1 hashing in Dart
  // This is a placeholder function
  // Example: https://pub.dev/packages/crypto
  return base64.encode(utf8.encode(input));
}

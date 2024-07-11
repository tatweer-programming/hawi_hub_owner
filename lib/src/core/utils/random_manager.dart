import 'dart:math';

class RandomManager {
  static String generateRandomString() {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(30, (index) => chars[r.nextInt(chars.length)]).join();
  }
}

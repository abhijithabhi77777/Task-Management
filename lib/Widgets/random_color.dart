import 'dart:math';
import 'dart:ui';

Color randomColor() {
  final Random random = Random();
  final int red = random.nextInt(256);
  final int green = random.nextInt(256);
  final int blue = random.nextInt(256);

  return Color.fromARGB(255, red, green, blue);
}

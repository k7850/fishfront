import 'package:flutter/material.dart';

Color idColorMake(int id) {
  int colorChange(int colorInt) {
    colorInt %= 255;
    while (colorInt < 50) {
      colorInt += 10;
    }
    while (colorInt > 200) {
      colorInt -= 10;
    }
    return colorInt;
  }

  return Color.fromRGBO(colorChange(id * 55), colorChange(id * 155), colorChange(id * 222), 0.5);
}

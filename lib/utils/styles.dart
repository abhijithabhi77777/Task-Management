import 'package:flutter/material.dart';

import 'pallete.dart';

LinearGradient commonGradient = const LinearGradient(colors: [
  Pallete.gradient1,
  Pallete.gradient2,
  Pallete.gradient3,
], begin: Alignment.centerRight, end: Alignment.centerLeft);

TextStyle logInWaringText = const TextStyle(
    color: Colors.white, // Text color
    fontSize: 16, // Text font size
    fontWeight: FontWeight.w400,
    height: 1.5 // Text font weight
    );
TextStyle fiedText = const TextStyle(
  color: Colors.grey, // Text color
  fontSize: 16, // Text font size
  fontWeight: FontWeight.bold, // Text font weight
);
TextStyle dataFiedText = const TextStyle(
  color: Color.fromARGB(255, 85, 83, 83), // Text color
  fontSize: 18, // Text font size
  fontWeight: FontWeight.bold, // Text font weight
);
TextStyle textFieldHintText = const TextStyle(
  color: Pallete.textFieldHintColor, // Text color
  fontSize: 20, // Text font size
  fontWeight: FontWeight.w500, // Text font weight
);
TextStyle titleText = const TextStyle(
  color: Pallete.titleBlack, // Text color
  fontSize: 22, // Text font size
  fontWeight: FontWeight.w600, // Text font weight
);
TextStyle subtitleText = const TextStyle(
  color: Pallete.subtitleBlack, // Text color
  fontSize: 22, // Text font size
  fontWeight: FontWeight.w400, // Text font weight
);
TextStyle tableHeadText = const TextStyle(
  color: Pallete.gradient1,
  // Text color
  fontSize: 16,
  // Text font size
  fontWeight: FontWeight.w600,
  height: 1,
  // Text font weight
  overflow: TextOverflow.visible,
);
TextStyle tableDataText = const TextStyle(
  color: Pallete.tableDatatextColor, // Text color
  fontSize: 16, // Text font size
  fontWeight: FontWeight.w400, // Text font weight
);
ButtonStyle filterButton = ButtonStyle(
  iconSize: MaterialStateProperty.all(10),
  backgroundColor: MaterialStateProperty.all(Pallete.textFieldBorderColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0),
    ),
  ),
);

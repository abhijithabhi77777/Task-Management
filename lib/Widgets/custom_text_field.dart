import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/pallete.dart';
import '../utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double fieldWidth;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.fieldWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 66,
          maxWidth: screenwidth! * fieldWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: dataFiedText,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Pallete.textFieldBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Pallete.textFieldBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              labelText: hintText,
              labelStyle: textFieldHintText,
              // label: Text(
              //   hintText,
              //   style: textFieldHintText,
              // ),
            ),
          ),
        ));
  }
}

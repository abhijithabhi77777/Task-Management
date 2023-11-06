import 'package:flutter/material.dart';
import 'package:task_management_web_app/utils/pallete.dart';

import '../pages/login/login_screen_controller.dart';
import '../utils/styles.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback buttonFunction;

  const GradientButton({
    super.key,
    required this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: commonGradient,
      ),
      child: ElevatedButton(
        onPressed: buttonFunction, // Pass the reference to the function
        onLongPress: () {
          print("testing....");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: const Size(395, 55),
        ),
        child: const Text(
          'Sign in',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class GradientSubmitButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonFuntion;

  const GradientSubmitButton({
    required this.buttonText,
    required this.buttonFuntion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: commonGradient,
      ),
      child: ElevatedButton(
        onPressed: buttonFuntion,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            fixedSize: const Size(330, 65)),
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Pallete.whiteColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

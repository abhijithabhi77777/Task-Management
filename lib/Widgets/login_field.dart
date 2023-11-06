import 'package:flutter/material.dart';
import 'package:task_management_web_app/utils/pallete.dart';
import 'package:get/get.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final RxBool isPasswordVisible = false.obs;
  final TextEditingController controller;

  LoginField(
      {required this.controller,
      required this.hintText,
      required this.isPassword,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Obx(
        () {
          return TextFormField(
            controller: controller,
            obscureText: !isPasswordVisible.value && isPassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Pallete.borderColor, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Pallete.gradient2, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              hintText: hintText,
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () {
                        isPasswordVisible.toggle();
                        // Toggle password visibility using GetX
                      },
                      child:
                          // Obx(
                          //   () {
                          // return
                          Visibility(
                        visible: isPassword,
                        child: Icon(
                          isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      // ;
                      //   },
                      // ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

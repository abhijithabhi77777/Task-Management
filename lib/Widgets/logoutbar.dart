import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/login/login_screen.dart';
import '../utils/styles.dart';

class logOutBar extends StatelessWidget {
  const logOutBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: commonGradient,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 60,
      child: GestureDetector(
        onTap: () {
          Get.offAll(const LoginScreen());
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.logout),
            Text(
              'Log Out',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:task_management_web_app/utils/pallete.dart';
import 'package:task_management_web_app/utils/globals.dart' as globals;

import '../utils/styles.dart';
import 'random_color.dart';

class NavBar extends StatefulWidget {
  final int countStaff;
  final int countProject;
  final String loginName;
  final String loginPosition;

  const NavBar({required this.countStaff,
    required this.loginName,
    required this.loginPosition,
    required this.countProject,
    super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final isDropdownOpen = RxBool(false);

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileNavBar(),
      desktop: DesktopNavBar(),
      tablet: tabletNavBar(),
    );
  }

  Widget? tabletNavBar() {
    return const SizedBox();
  }

  Widget mobileNavBar() {
    return const SizedBox();
  }

  Widget DesktopNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Pallete.whiteColor,
      ),
      //     margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navLogo(),
          Row(
            children: [
              count(widget.countStaff.toString(), 'Total Staff',
                  const Color.fromARGB(255, 88, 236, 93)),
              const SizedBox(
                width: 20,
              ),
              count(
                  widget.countProject.toString(), 'Total Projects', Colors.red),
              const SizedBox(
                width: 40,
              ),
              profile(widget.loginName.toString(), widget.loginPosition),
            ],
          )
        ],
      ),
    );
  }

  Widget count(String count, String text, Color circleColor) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Set the shape to circle
            color: circleColor, // Set the background color
          ),
          width: 50,
          // Set the width
          height: 50,
          // Set the height
          child: Center(
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Pallete.whiteColor,
              ),
            ),
          ),
        ),
        Text(text, style: titleText),
      ],
    );
  }

  Widget avatar() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              shape: BoxShape.circle, // Set the shape to circle
              // Set the background color
              image: DecorationImage(fit: BoxFit.fill,
                  image: AssetImage("assets/${globals.avatarName}.jpg"))
          ),
          width: 50,
          // Set the width
          height: 50,
          // Set the height
        )


      ],
    );
  }

  Widget navLogo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      width: 110,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/logo.png'))), //assets/images/signin_balls.png
    );
  }

  Widget profile(String name, String role) {
    print(name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Pallete.titleBlack,
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                formattedDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Pallete.dateGray,
                  fontSize: 14,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              globals.avatarName != null
                  ? avatar()
                  : count(name[0], '', randomColor()),
              Text(
                role,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget navButton(String text, Widget page) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {
          Get.to(page);
          print('click');
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

// Widget navLogo() {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 50),
//     width: 110,
//     decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage(
//                 'assets/images/logo.png'))), //assets/images/signin_balls.png
//   );
// }
}

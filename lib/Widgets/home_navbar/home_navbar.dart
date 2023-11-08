import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:task_management_web_app/Widgets/home_navbar/home_navbar_controller.dart';
import 'package:task_management_web_app/pages/add_projects/add_project_screen.dart';
import 'package:task_management_web_app/pages/add_staff/add_staff_screen.dart';
import 'package:task_management_web_app/utils/pallete.dart';
import 'package:task_management_web_app/utils/globals.dart' as globals;

import '../../pages/home/home_screen.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../dropdown_deom.dart';

class HomeNavBar extends StatelessWidget {
  HomeNavBar({super.key});

  final HomeNavbarController _homeNavbarController = HomeNavbarController();
  final isDropdownOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileHomeNavBar(),
      desktop: desktopHomeNavBar(),
    );
  }

  Widget mobileHomeNavBar() {
    return Container(
      color: Pallete.whiteColor,
      //margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(right: 30),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 100, child: navLogo()),
              GestureDetector(
                onTap: () {
                  isDropdownOpen.value = !isDropdownOpen.value;
                },
                child: const Icon(
                  Icons.heart_broken,
                  color: Pallete.borderColor,
                ),
              ),
            ],
          ),
          Obx(() => isDropdownOpen.value
              ? Column(
                  children: [
                    navButton(true, 'assets/images/downArrow.png',
                        'Current Projects', titleText, null, 26),
                    navButton(true, 'assets/images/addStaff.png', 'Add Staff',
                        titleText, AddStaffScreen(), 22),
                    navButton(false, 'assets/images/addProjectIcon.png',
                        'Add Project', titleText, AddProjectScreen(), 22),
                  ],
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget desktopHomeNavBar() {
    return Container(
      color: Pallete.backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      //height: screenheight! * .20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //const CustomDropdown(iconUrl: '', text: 'text'),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: navButton(false, 'assets/images/downArrow.png',
                      'Current Projects', titleText, AddStaffScreen(), 42),
                ),
              ),
              Expanded(
                flex: 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //  navButton('Home', const HomeScreen()),
                    navButton(true, 'assets/images/addStaff.png', 'Add Staff',
                        titleText, AddStaffScreen(), 42),
                    navButton(true, 'assets/images/addProjectIcon.png',
                        'Add Project', titleText, AddProjectScreen(), 42),
                    navButton(false, 'assets/images/search.png', 'Search',
                        subtitleText, const HomeScreen(), 42),
                    navButton(false, 'assets/images/sort.png', 'Sort by',
                        subtitleText, const HomeScreen(), 42),
                    // filterButton(
                    //     'assets/images/filter.png', 'Filter', subtitleText, 42),
                  ],
                ),
              )
            ],
          ),
          Obx(
            () => _homeNavbarController.isFilter.isTrue
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    color: Colors.black12,
                    width: screenwidth! * 1,
                    // height: screenheight! * .30,
                    child: FilterUI(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget navButton(bool adminFeatures, String imageUrl, String text,
      TextStyle textStyle, Widget? page, double iconSize) {
    return globals.loginPosition == 'admin' || (!adminFeatures)
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              onPressed: () {
                Get.to(page);
                print('click');
              },
              child: Row(
                children: [
                  Image.asset(
                    imageUrl,
                    height: iconSize,
                    width: iconSize,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          )
        : const SizedBox(width: 100);
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

  Widget filterButton(
      String imageUrl, String text, TextStyle textStyle, double iconSize) {
    return GestureDetector(
      onTap: () {
        if (_homeNavbarController.isFilter.isTrue) {
          _homeNavbarController.isFilter.value = false;
          print(_homeNavbarController.isFilter.value);
        } else {
          _homeNavbarController.isFilter.value = true;
        }
      },
      child: Row(
        children: [
          Image.asset(imageUrl, height: iconSize, width: iconSize),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

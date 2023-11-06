import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:task_management_web_app/Widgets/avatar_dropdown.dart';
import 'package:task_management_web_app/Widgets/home_navbar/home_navbar.dart';
import 'package:task_management_web_app/Widgets/navbar.dart';
import 'package:task_management_web_app/pages/add_staff/add_staff_screen_controller.dart';
import 'package:task_management_web_app/utils/pallete.dart';

import '../../Widgets/custom_text_field.dart';
import '../../Widgets/gradient_button.dart';
import '../../Widgets/logoutbar.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../home/home_screen.dart';

class AddStaffScreen extends StatelessWidget {
  final AddStaffScreenController addStaffScreenController =
      AddStaffScreenController();
  final TextEditingController staffNameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController mailIdController = TextEditingController();
  final TextEditingController employmentTypeController =
      TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController xxController = TextEditingController();

  AddStaffScreen({super.key});

  // String _avatarName = 'avatar-b-1';
  bool areTextFieldsFilled() {
    return staffNameController.text.isNotEmpty &&
        roleController.text.isNotEmpty &&
        mailIdController.text.isNotEmpty &&
        employmentTypeController.text.isNotEmpty &&
        passWordController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        employeeIdController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileHomeNavBar(),
      desktop: desktopHomeNavBar(),
      // tablet: tabletStafCard(),
    );
  }

  // avatarName(String name) {
  //   _avatarName = name;
  // }

  Widget mobileHomeNavBar() {
    {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 248, 250),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const logOutBar(),
                //const NavBar(),
                Center(
                  child: Container(
                    width: screenwidth! * .9,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallete.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add a Staff',
                          style: titleText,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: staffNameController,
                          hintText: 'Name of Staff',
                          fieldWidth: .90,
                        ),
                        CustomTextField(
                            controller: roleController,
                            hintText: 'Role',
                            fieldWidth: .90),
                        CustomTextField(
                            controller: mailIdController,
                            hintText: 'Email ID',
                            fieldWidth: .90),
                        CustomTextField(
                            controller: employmentTypeController,
                            hintText: 'Employment Type',
                            fieldWidth: .90),
                        CustomTextField(
                            controller: passWordController,
                            hintText: 'Password',
                            fieldWidth: .90),
                        CustomTextField(
                            controller: employeeIdController,
                            hintText: 'Employee ID',
                            fieldWidth: .90),
                        CustomTextField(
                            controller: positionController,
                            hintText: 'Position',
                            fieldWidth: .90),
                        AvatarDropDown(
                            onAvatarSelected:
                                addStaffScreenController.handleAvatarSelection),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientSubmitButton(
                                buttonText: 'Submit',
                                buttonFuntion: () {
                                  if (areTextFieldsFilled()) {
                                    addStaffScreenController.isNewStaff(
                                      staffNameController.text,
                                      mailIdController.text,
                                      passWordController.text,
                                      positionController.text,
                                      roleController.text,
                                      employeeIdController.text,
                                      employmentTypeController.text,
                                      addStaffScreenController.atrName.value,
                                    );
                                  } else {
                                    // Show a warning because not all fields are filled
                                    Get.snackbar(
                                      'Warning',
                                      'Please fill in all fields.',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                }),
                            GradientSubmitButton(
                              buttonText: 'Cancel',
                              buttonFuntion: Get.back,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget desktopHomeNavBar() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 248, 250),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const logOutBar(),
              // const NavBar(),
              Center(
                child: Container(
                  width: screenwidth! * .9,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Pallete.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add a Staff',
                        style: titleText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      textFieldRow(staffNameController, 'Name of Staff',
                          roleController, 'Role'),
                      textFieldRow(mailIdController, 'Email ID',
                          employmentTypeController, 'Employment Type'),
                      textFieldRow(passWordController, 'Password',
                          employeeIdController, 'Employee ID'),
                      textFieldRow(positionController, 'Position',
                          roleController, 'Avatar'),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientSubmitButton(
                              buttonText: 'Submit',
                              buttonFuntion: () {
                                if (areTextFieldsFilled()) {
                                  addStaffScreenController.isNewStaff(
                                    staffNameController.text,
                                    mailIdController.text,
                                    passWordController.text,
                                    positionController.text,
                                    roleController.text,
                                    employeeIdController.text,
                                    employmentTypeController.text,
                                    addStaffScreenController.atrName.value,
                                  );
                                  disposeStaff();
                                  Get.offAll(const HomeScreen());
                                } else {
                                  // Show a warning because not all fields are filled
                                  Get.snackbar(
                                    'Warning',
                                    'Please fill in all fields.',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              }),
                          GradientSubmitButton(
                              buttonText: 'Cancel',
                              buttonFuntion: () {
                                disposeStaff();
                                Get.back();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void disposeStaff() {
    staffNameController.text = '';
    roleController.text = '';
    mailIdController.text = '';
    employmentTypeController.text = '';
    passWordController.text = '';
    positionController.text = '';
    employeeIdController.text = '';
  }

  Widget textFieldRow(TextEditingController controller1, String hint1,
      TextEditingController controller2, String hint2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextField(
            controller: controller1, hintText: hint1, fieldWidth: .40),
        hint2 != 'Avatar'
            ? CustomTextField(
                controller: controller2, hintText: hint2, fieldWidth: .40)
            : AvatarDropDown(
                onAvatarSelected:
                    addStaffScreenController.handleAvatarSelection),
      ],
    );
  }
}

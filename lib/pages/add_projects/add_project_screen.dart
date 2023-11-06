import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_management_web_app/pages/add_projects/add_projectscreen_controller.dart';
import 'package:task_management_web_app/pages/home/home_screen.dart';
import 'package:task_management_web_app/pages/home/home_screen_controller.dart';

import '../../Widgets/custom_text_field.dart';
import '../../Widgets/gradient_button.dart';
import '../../Widgets/logoutbar.dart';
import '../../Widgets/navbar.dart';
import '../../utils/constants.dart';
import '../../utils/pallete.dart';
import '../../utils/styles.dart';

class AddProjectScreen extends StatelessWidget {
  AddProjectScreen({super.key});

  final AddProjectScreenController _addProjectScreenController =
      AddProjectScreenController();
  final HomeScreenController homeScreenCountController = HomeScreenController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 248, 250),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          const logOutBar(),
          //   NavBar(),
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
                    'Add a Project',
                    style: titleText,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textFieldRow(clientNameController, 'Name of Client',
                      projectNameController, 'Name of Project'),
                  textArea(
                    screenwidth! * .825,
                    300,
                    'project description',
                    myController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientSubmitButton(
                        buttonText: 'Submit',
                        buttonFuntion: () {
                          if (validateFields()) {
                            _addProjectScreenController.isNewProject(
                                clientNameController.text,
                                projectNameController.text,
                                myController.text);
                            dispose();
                            homeScreenCountController.allProjectCount();

                            Get.offAll(const HomeScreen());
                          } else {
                            Get.snackbar(
                              'Warning',
                              'Please fill in all fields.',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                      ),
                      GradientSubmitButton(
                          buttonText: 'Cancel',
                          buttonFuntion: () {
                            dispose();
                            Get.back();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]))));
  }

  void dispose() {
    clientNameController.text = '';
    projectNameController.text = '';
    myController.text = '';
  }

  bool validateFields() {
    return clientNameController.text.isNotEmpty &&
        projectNameController.text.isNotEmpty &&
        myController.text.isNotEmpty;
  }

  Widget textFieldRow(TextEditingController controller1, String hint1,
      TextEditingController controller2, String hint2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextField(
            controller: controller1, hintText: hint1, fieldWidth: .40),
        CustomTextField(
            controller: controller2, hintText: hint2, fieldWidth: .40)
      ],
    );
  }

  Widget textArea(double width, double height, String hintText,
      TextEditingController controller) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
          maxWidth: width,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 5,
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

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_web_app/Widgets/data_table/data_table_controller.dart';
import 'package:task_management_web_app/pages/home/home_screen.dart';
import 'package:task_management_web_app/utils/constants.dart';

import '../utils/styles.dart';
import 'data_table/data_table.dart';
import 'date_picker_text_field.dart';

class FilterUI extends StatefulWidget {
  @override
  _FilterUIState createState() => _FilterUIState();
}

class _FilterUIState extends State<FilterUI> {
  final DataTableController dataTableController = DataTableController();
  List<String> projectOptions = [];
  List<String> assigneeOptions = [];

  @override
  void initState() {
    dataTableController.getAllProjectNameList();
    dataTableController.getAllStaffNamesList();

    projectOptions = dataTableController.projectNameList;

    assigneeOptions = dataTableController.staffLIst;
    super.initState();
  }

  String selectedHeading = "Date";

  // Define options for the sub-lists
  List<String> statusOptions = [
    "All Statuses",
    "In Progress",
    "Completed",
    "On Hold"
  ];
  List<String> billableOptions = ["Yes", "No"];

  // Store the selected items in each sub-list
  List<String> selectedProjects = [];
  List<String> selectedAssignees = [];
  String selectedStatus = "All Statuses";
  String selectedBillable = "Yes";

  String? fromDate;
  String? toDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              heading("Date"),
              heading("Projects"),
              heading("Assignees"),
              heading("Status"),
              heading("Billable"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      printSelectedValues(); // Print all selected values
                    },
                    child: const Text("Apply Filters"),
                  ),
                  Obx(() => Text(
                        "${dataTableController.isFilter.value}",
                        style: tableDataText,
                      ))
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                  // width: screenwidth! * .5,
                  height: screenheight! * .20,
                  child: SingleChildScrollView(
                      child: subList(projectOptions, assigneeOptions))),
            ],
          ),
        ],
      ),
    );
  }

  Widget heading(String heading) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedHeading = heading;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          heading,
          style: TextStyle(
            fontWeight: selectedHeading == heading ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }

  Widget subList(List<String> projectOptions, List<String> assigneeOptions) {
    if (selectedHeading == "Date") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From:',
            style: tableDataText,
          ),
          const SizedBox(width: 16.0),
          DatePickerTextFieldNew(
            fieldText: tableDataText,
            dateinput: TextEditingController(
              text: "00",
            ),
            onChanged: (date) {
              setState(() {
                fromDate = _formatDate(date);
                print("date::::::000$date");
              });
            },
          ),
          const SizedBox(width: 16.0),
          Text(
            'To:',
            style: tableDataText,
          ),
          DatePickerTextFieldNew(
            fieldText: tableDataText,
            dateinput: TextEditingController(),
            onChanged: (date) {
              setState(() {
                toDate = _formatDate(date);
              });
            },
          ),
        ],
      );
    } else if (selectedHeading == "Projects") {
      return Column(
        children: projectOptions.map((String project) {
          return CheckboxListTile(
            title: Text(project),
            value: selectedProjects.contains(project),
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  selectedProjects.add(project);
                } else {
                  selectedProjects.remove(project);
                }
              });
            },
          );
        }).toList(),
      );
    } else if (selectedHeading == "Assignees") {
      return Column(
        children: assigneeOptions.map((String assignee) {
          return CheckboxListTile(
            title: Text(assignee),
            value: selectedAssignees.contains(assignee),
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  selectedAssignees.add(assignee);
                } else {
                  selectedAssignees.remove(assignee);
                }
              });
            },
          );
        }).toList(),
      );
    } else if (selectedHeading == "Status") {
      return Column(
        children: statusOptions.map((String status) {
          return RadioListTile<String>(
            title: Text(status),
            value: status,
            groupValue: selectedStatus,
            onChanged: (String? value) {
              setState(() {
                selectedStatus = value!;
              });
            },
          );
        }).toList(),
      );
    } else if (selectedHeading == "Billable") {
      return Column(
        children: billableOptions.map((String billable) {
          return RadioListTile<String>(
            title: Text(billable),
            value: billable,
            groupValue: selectedBillable,
            onChanged: (String? value) {
              setState(() {
                selectedBillable = value!;
              });
            },
          );
        }).toList(),
      );
    } else {
      return Container(); // Empty sub-list
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
    ;
  }

  void printSelectedValues() {
    dataTableController.isFilter.value = true;

    String selectedFromDate =
        fromDate ?? DateFormat('yyyy-MM-dd').format(DateTime(2023, 1, 1));
    String selectedToDate =
        toDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    dataTableController.getFilterList(
        selectedFromDate!,
        selectedToDate!,
        selectedProjects!,
        selectedAssignees!,
        selectedStatus!,
        selectedBillable!);
    dataTableController.getFilterList(
        '2023-01-31', '2023-10-31', [], [], null, 'Yes');
    // Print all selected values
    print("Selected Items:");
    print("From Date: $fromDate");
    print("To Date: $toDate");
    print("Projects: $selectedProjects");
    print("Assignees: $selectedAssignees");
    print("Status: $selectedStatus");
    print("Billable: $selectedBillable");
    // dataTableController.updateFetchedData();
  }
}

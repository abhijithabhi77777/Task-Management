import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_web_app/Widgets/circle_button.dart';
import 'package:task_management_web_app/Widgets/custom_dropdown/custome_dropdowns.dart';
import 'package:task_management_web_app/models/task_model.dart';
import 'package:task_management_web_app/pages/home/home_screen.dart';
import 'package:task_management_web_app/pages/home/home_screen_controller.dart';
import 'package:task_management_web_app/utils/constants.dart';
import 'package:task_management_web_app/utils/pallete.dart';
import 'package:task_management_web_app/utils/common_lists.dart';
import 'dart:html' as html;
import '../../utils/styles.dart';
import '../custom_filter_dropdown/custom_dropdown.dart';
import '../custome_filter_datepicker.dart';
import '../date_picker_text_field.dart';
import '../loading_spinner.dart';
import 'data_table_controller.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  String selectedProject = ''; // To store the selected project
  String selectedAssignee = ''; // To store the selected assignee
  String selectedStatus = ''; // To store the selected status
  String selectedBill = ''; // To store the selected billable
  String? selectedToDate;

  String? selectedFromDate;

///////////////////////////////////////////////////////////////////
  List<DataRow> dataRows = [];
  final dataTableController = Get.put(DataTableController());
  final DataTableController dataController = Get.put(DataTableController());
  final RowController _rowController = Get.put(RowController());


//////////////////////////////////////////////////////

  void updateSelectedProject(String? value) {
    selectedProject = value!;
  }

  void updateSelectedAssignee(String? value) {
    selectedAssignee = value!;
  }

  void updateSelectedStatus(String? value) {
    selectedStatus = value!;
  }

  void updateSelectedBill(String? value) {
    selectedBill = value!;
  }

  void updateSelectedFromDate(String? value) {
    selectedFromDate = value;
  }

  void updateSelectedToDate(String? value) {
    selectedToDate = value;
  }

  ////////////////////////////////////////////////////////////////////////////////
  TextField buildTextField(int index, Rx<String> valueController) {
    final rowController = dataController.rowControllers[index];
    String initialValue = valueController.value;

    return TextField(
      style: tableDataText,
      controller: TextEditingController(text: initialValue),
      onChanged: (value) {
        valueController.value = value;
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////////////

  DropdownButton<String> buildDropdown(int dropId,
      int index,
      List<String> items,
      Rx<String> valueController,
      int? rowId,
      double textWidth) {
    final rowController = dataController.fetchedData[index];
    int dropDownId = dropId;
    int? rowFieldId = rowId;
    String selectedValue = valueController.value;

// Check if the selected value exists in the list of items
    if (!items.contains(selectedValue)) {
      selectedValue = items.first; // Use a default value or handle it as needed
      valueController.value = selectedValue; // Update the value controller
    }

    return DropdownButton<String>(
      iconEnabledColor: Pallete.tableDatatextColor,
      value: selectedValue,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: SizedBox(
            width: screenwidth! * textWidth,
            child: Text(
              item,
              style: tableDataText,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        switch (dropDownId) {
          case 1:
            dataTableController.updateProjectNameInTask(rowFieldId!, value!);
            //dataTableController.updateFetchedData();
            break;
          case 2:
            dataTableController.updateAssigneeNameInTask(rowFieldId!, value!);

            break;
          case 3:
            dataTableController.updateBillableInTask(rowFieldId!, value!);

            break;

          default:
            rowController.isEditing.value = false;
            valueController.value = value!;
        // Code to execute when none of the case values match the expression
        }
      },
    );
  }

  @override
  void initState() {
    dataTableController.getAllTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenheight = MediaQuery
        .of(context)
        .size
        .height;
    return dataTableController.isLoading.isTrue ?
    const LoadingSpinner()
        : Column(
      children: [
        Container(
          width: screenwidth * 1,
          height: screenheight * .1,
          color: Colors.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          // child: SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              StylingDatePicker(
                onDateSelected: updateSelectedFromDate,
              ),
              const SizedBox(
                width: 10,
              ),
              StylingDatePicker(
                onDateSelected: updateSelectedToDate,
              ),
              const SizedBox(
                width: 10,
              ),
              StylingDropDown(
                dropText: 'Select Project',
                listItems: dataController.projectNameList,
                iconUrl: 'assets/images/project_icon.png',
                onItemSelected: updateSelectedProject,
              ),
              const SizedBox(
                width: 10,
              ),
              StylingDropDown(
                dropText: 'Select Assignee',
                listItems: dataController.staffLIst,
                iconUrl: 'assets/images/assignee_icon.png',
                onItemSelected: updateSelectedAssignee,
              ),
              const SizedBox(
                width: 10,
              ),
              StylingDropDown(
                dropText: 'Select Status',
                listItems: statusList,
                iconUrl: 'assets/images/status_icon.png',
                onItemSelected: updateSelectedStatus,
              ),
              const SizedBox(
                width: 10,
              ),
              StylingDropDown(
                dropText: 'Billable',
                listItems: billableList,
                iconUrl: 'assets/images/bill_icon.png',
                onItemSelected: updateSelectedBill,
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: filterButton,
                onPressed: () {
                  String fromDate = selectedFromDate ??
                      DateFormat('yyyy-MM-dd').format(DateTime(2023, 1, 1));
                  String toDate = selectedToDate ??
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                  dataTableController.getFilterList(
                      fromDate,
                      toDate,
                      [selectedProject],
                      [selectedAssignee],
                      selectedStatus,
                      (selectedBill != '')
                          ? selectedBill
                          : "Yes"); // Print all selected values
                },
                child: Image.asset(
                  'assets/images/filter.png', width: 48,
                  // Adjust the size as needed
                  height: 48,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  Get.offAll(const HomeScreen());
                },
                child: Text(
                  "X",
                  style: titleText,
                ),
              ),
            ],
          ),
          // ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Display a table for fetched data
                  Obx(() {
                    /////////////////////////////////////////////////////

                    ////////////////////////////////////////////////////////////
                    dataController.updateFetchedData();
                    final fetchedDataRows =
                    dataController.fetchedData
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;

                      final task = entry.value;

                      final rowControllerfetch =
                      dataTableController.fetchedData[index];
                      return DataRow(
                        cells: [
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return rowController.isEditing.value
                                    ? SizedBox(
                                  width: screenwidth * .07,
                                  child: DatePickerTextField(
                                    fieldText: tableDataText,
                                    dateinput: TextEditingController(
                                        text: dataController
                                            .fetchedData[index].date),
                                    onChanged: (Value) {
                                      rowController.date = Value;
                                    },
                                  ),
                                )
                                    : Text(rowControllerfetch.date,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center);
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return rowController.isEditing.value
                                    ? SizedBox(
                                  width: screenwidth * .1,
                                  child: buildDropdown(
                                      1,
                                      index,
                                      dataController.projectNameList,
                                      rowController
                                          .projectValueControllerFetchedData,
                                      task.id,
                                      .08),
                                )
                                    : Text(rowControllerfetch.project,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center);
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .1,
                                  child: rowController.isEditing.value
                                      ? buildDropdown(
                                      2,
                                      index,
                                      // ['abhijith', 'ramya', 'vivek', 'manoj'],
                                      dataController.staffLIst,
                                      rowController.nameValueController,
                                      task.id,
                                      .08)
                                      : Text(rowControllerfetch.assignee,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .175,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    maxLines: 10,
                                    controller: TextEditingController(
                                        text: rowController.task ??
                                            "not named"),
                                    // Use "not named" if task is null
                                    onChanged: (value) {
                                      rowController.task = value;
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(
                                      rowControllerfetch.task ??
                                          "not named",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .175,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.comments ??
                                            "No Comments"),
                                    onChanged: (value) {
                                      rowController.comments = value;
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(
                                      rowControllerfetch.comments ??
                                          "No Comments",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.originalEst
                                            .toString()),
                                    onChanged: (value) {
                                      rowController.originalEst =
                                          int.parse(value);
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(
                                      rowControllerfetch.originalEst
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.completedHr
                                            .toString()),
                                    onChanged: (value) {
                                      rowController.completedHr =
                                          int.parse(value);
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(
                                      rowControllerfetch.completedHr
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .075,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.status),
                                    onChanged: (value) {
                                      rowController.status = value;
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(rowControllerfetch.status,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.billableHr
                                            .toString()),
                                    onChanged: (value) {
                                      rowController.billableHr =
                                          int.parse(value);
                                    },
                                    style: tableDataText,
                                  )
                                      : Text(
                                      rowControllerfetch.billableHr
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.fetchedData[index];
                                return SizedBox(
                                  width: screenwidth * .04,
                                  child: rowController.isEditing.value
                                      ? buildDropdown(
                                      3,
                                      index,
                                      [
                                        'Yes',
                                        'No',
                                      ],
                                      rowController.billableValueController,
                                      task.id,
                                      .02)
                                      : Text(rowControllerfetch.billable,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () =>
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          task.isEditing.value
                                              ? Icons.save
                                              : Icons.edit,
                                          color: Pallete.tableDatatextColor,
                                        ),
                                        onPressed: () {
                                          if (task.isEditing.value) {
                                            print("Task id ::111:${task.id}");

                                            dataController.updateTask(
                                                task.id,
                                                task.date,
                                                task.project,
                                                task.assignee,
                                                task.task ?? "Not Named",
                                                task.comments ?? "No Comments",
                                                task.originalEst ?? 0,
                                                task.completedHr ?? 0,
                                                task.status,
                                                task.billableHr ?? 0,
                                                task.billable);
                                            task.toggleEdit();
                                          } else {
                                            task.toggleEdit();
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Pallete.tableDatatextColor,
                                        ),
                                        onPressed: () {
                                          dataController.deleteTasks(task.id);
                                        },
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      );
                    }).toList();

                    // Create a list for user-added data rows
                    final userAddedDataRows = dataController.rowControllers
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final rowController = entry.value;

                      return DataRow(
                        cells: [
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .07,
                                  child: rowController.isEditing.value
                                      ? DatePickerTextField(
                                    fieldText: tableDataText,
                                    dateinput: TextEditingController(
                                        text: dataController
                                            .rowControllers[index]
                                            .ageValue
                                            .value),
                                    onChanged: (Value) {
                                      rowController.ageValue.value =
                                          Value;
                                    },
                                  )
                                      : Text(rowController.ageValue.value,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .1,
                                  child: rowController.isEditing.value
                                      ? buildDropdown(
                                      0,
                                      index,
                                      dataController.projectNameList,
                                      rowController.projectValueController,
                                      -1,
                                      .08)
                                      : Text(
                                    rowController
                                        .projectValueController.value,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .1,
                                  child: rowController.isEditing.value
                                      ? buildDropdown(
                                      0,
                                      index,
                                      dataController.staffLIst,
                                      rowController.nameValueController,
                                      -1,
                                      .08)
                                      : Text(
                                      rowController
                                          .nameValueController.value,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .175,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.taskValue),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.taskValue = value;
                                    },
                                  )
                                      : Text(rowController.taskValue,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .175,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.commentVale),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.commentVale = value;
                                    },
                                  )
                                      : Text(rowController.commentVale,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.originalEst),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.originalEst = value;
                                    },
                                  )
                                      : Text(rowController.originalEst,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.completedEst),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.completedEst = value;
                                    },
                                  )
                                      : Text(rowController.completedEst,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .075,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    controller: TextEditingController(
                                        text: rowController.statusValu),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.statusValu = value;
                                    },
                                  )
                                      : Text(rowController.statusValu,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .025,
                                  child: rowController.isEditing.value
                                      ? TextField(
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(
                                        text: rowController.billableHr),
                                    style: tableDataText,
                                    onChanged: (value) {
                                      rowController.billableHr = value;
                                    },
                                  )
                                      : Text(rowController.billableHr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () {
                                final rowController =
                                dataController.rowControllers[index];
                                return SizedBox(
                                  width: screenwidth * .04,
                                  child: rowController.isEditing.value
                                      ? buildDropdown(
                                      0,
                                      index,
                                      [
                                        'Yes',
                                        'No',
                                      ],
                                      rowController.billableValueController,
                                      -1,
                                      .02)
                                      : Text(
                                      rowController
                                          .billableValueController.value,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Obx(
                                  () =>
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          rowController.isEditing.value
                                              ? Icons.save
                                              : Icons.edit,
                                          color: Pallete.tableDatatextColor,
                                        ),
                                        onPressed: () {
                                          if (rowController.isEditing.value) {
                                            print("Test logic");
                                            dataController.addRowData(index);
                                            // rowController.toggleEdit();
                                          } else {
                                            // rowController.toggleEdit();
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Pallete.tableDatatextColor,
                                        ),
                                        onPressed: () {
                                          dataController.deleteRow(index);
                                        },
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      );
                    }).toList();

                    // Combine the fetched data rows and user-added data rows
                    final combinedDataRows = [
                      ...fetchedDataRows,
                      ...userAddedDataRows
                    ];

                    return DataTable(
                      border: TableBorder.all(
                          color: Pallete.tableHeadBGColor, width: 2),
                      //showBottom,
                      columnSpacing: 10,
                      showBottomBorder: true,
                      showCheckboxColumn: true,
                      dividerThickness: 5,
                      headingRowColor: MaterialStateProperty.all(
                        Pallete.tableHeadBGColor,
                      ),
                      dataRowColor:
                      MaterialStateProperty.all(Pallete.tabledataBGColor),
                      dataTextStyle: tableDataText,
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .070,
                            child: Text(
                              'Date',
                              style: tableHeadText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .1,
                            child: Text(
                              'Project',
                              style: tableHeadText,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .1,
                            child: Text(
                              'Assignee',
                              style: tableHeadText,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .175,
                            child: Text(
                              'Task',
                              style: tableHeadText,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .175,
                            child: Text(
                              'Comments',
                              overflow: TextOverflow.ellipsis,
                              style: tableHeadText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .025,
                            child: Text(
                              'Org.\nEst',
                              style: tableHeadText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .025,
                            child: Text(
                              'Comp\nHrs',
                              textAlign: TextAlign.left,
                              style: tableHeadText,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .075,
                            child: Text(
                              'Status',
                              style: tableHeadText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Bill\nHrs.',
                            style: tableHeadText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .025,
                            child: Text(
                              'Billable',
                              style: tableHeadText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: screenwidth * .04,
                            child: GradientCircularButton(
                              size: 42,
                              onPressed: () {
                                dataController.addRow();
                              },
                            ),
                          ),
                        ),
                      ],
                      rows:
                      combinedDataRows, // Combine fetched and user-added data rows
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

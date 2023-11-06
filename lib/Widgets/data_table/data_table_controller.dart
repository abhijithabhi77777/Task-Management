import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/models/task_adding_response.dart';
import 'package:task_management_web_app/models/task_table_response_model.dart';
import 'package:task_management_web_app/pages/home/home_screen.dart';
import 'package:task_management_web_app/pages/home/home_screen_controller.dart';

import '../../api/api_manager.dart';
import '../../models/task_model.dart';

class RowController extends GetxController {
  var isEditing = true.obs;
  var nameValue = ''.obs;
  late Rx<String> ageValue;
  var projectValue = ''.obs;
  var taskValue = '';
  var billableValue = ''.obs;
  var commentVale = '';
  var originalEst = '';
  var completedEst = '';
  var statusValu = '';
  var billableHr = '';
  Rx<String> projectValueController =
      Rx<String>(''); // Separate controller for 'Project' dropdown
  Rx<String> nameValueController =
      Rx<String>(''); // Separate controller for 'Assignee' dropdown
  Rx<String> billableValueController = Rx<String>('');
  final RxBool isSelected = false.obs;

  RowController() {
    final currentDate = DateTime.now();
    ageValue =
        RxString("${currentDate.year}-${currentDate.month}-${currentDate.day}");
  }

  // Define a method to toggle the selection status
  void toggleSelection(bool selected) {
    isSelected.value = selected;
  }
}

class DataTableController extends GetxController {
  final isLoading = false.obs;
  var isEditing = false.obs;
  var isFilter = false.obs;
  RxList<TaskModel> fetchedData = <TaskModel>[].obs;
  RxList<String> staffLIst = <String>[].obs;
  RxList<String> projectNameList = <String>[].obs;

  final RxList<TaskListResponseModel> taskList = <TaskListResponseModel>[].obs;
  final RxList<TaskListResponseModel> filterTaskList =
      <TaskListResponseModel>[].obs;

  final RxList<TaskListResponseModel> userAddedRows =
      <TaskListResponseModel>[].obs;

  TaskAddingResponse? _taskAddingResponse;
  TaskListResponseModel? _taskListResponseModel;
  var rowControllers = <RowController>[].obs;
  List<TextEditingController> dateinputControllers = [];
  final HomeScreenController _homeScreenController = HomeScreenController();

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  // Method to set the task list from the API
  void setTaskList(List<TaskListResponseModel> list) {
    if (isFilter.isTrue) {
      filterTaskList.assignAll(list);
    } else {
      taskList.assignAll(list);
    }
  }

  // Method to add a new user-added row
  void addUserAddedRow(TaskListResponseModel row) {
    userAddedRows.add(row);
  }

  // stop Loading

  void addRow() {
    var newRowController = RowController();
    rowControllers.add(newRowController);
    // dateinputControllers.add(TextEditingController());

    newRowController.isEditing.listen((value) {
      // Handle the edit state change for this row
    });

    newRowController.nameValue.listen((value) {
      // Handle the name value change for this row
    });
    newRowController.projectValue.listen((value) {
      // Handle the name value change for this row
    });
    // newRowController.taskValue.listen((value) {
    //   // Handle the name value change for this row
    // });
    newRowController.billableValue.listen((value) {
      // Handle the name value change for this row
    });

    newRowController.ageValue.listen((value) {
      // Handle the age value change for this row
    });
  }

  void deleteRow(int rowIndex) {
    if (rowIndex >= 0 && rowIndex < rowControllers.length) {
      rowControllers.removeAt(rowIndex);
      //  dateinputControllers.removeAt(rowIndex);
    }
  }

  Future<void> addRowData(int rowIndex) async {
    int stringToInt(String input) {
      try {
        return int.parse(input);
      } catch (e) {
        // Handle parsing error, e.g., return a default value or throw an exception.
        return 0; // Default value
      }
    }

    final rowController = rowControllers[rowIndex];
    _taskAddingResponse = await APIManager.addTask(
        rowController.ageValue.value,
        rowController.projectValueController.value,
        rowController.nameValueController.value,
        rowController.taskValue,
        rowController.commentVale,
        stringToInt(rowController.originalEst),
        stringToInt(rowController.completedEst),
        rowController.statusValu,
        stringToInt(rowController.billableHr),
        rowController.billableValueController.value);

    if (_taskAddingResponse?.message == "new task created successfully") {
      print("Success...${_taskAddingResponse}");
    }
    if (rowIndex >= 0 && rowIndex < rowControllers.length) {
      final rowController = rowControllers[rowIndex];

      print("Row Data at Index $rowIndex:");
      print("Date: ${rowController.ageValue}");
      print("Project: ${rowController.projectValueController.value}");
      print("Task: ${rowController.taskValue}");
      print("Assignee: ${rowController.nameValueController.value}");
      print("Comments: ${rowController.commentVale}");
      print("Original Estimate: ${rowController.originalEst}");
      print("Completed Hours: ${rowController.completedEst}");
      print("Status: ${rowController.statusValu}");
      print("Billable Hours: ${rowController.billableHr}");
      print("Billable: ${rowController.billableValueController}");
    }
    getAllTaskList();
    deleteRow(rowIndex);
  }

  Future<void> getAllTaskList() async {
    isLoading.value = true;
    if (true) {
      try {
        List<TaskListResponseModel> taskList = await APIManager.getAllTask();
        print(taskList);
        print("1111111111111111111111111111111111");
        if (taskList.isNotEmpty) {
          setTaskList(taskList);
          updateFetchedData();
          // You have received a list of task items
          for (var task in taskList) {
            print("Task ID: ${task.id}");
            print("Date: ${task.date}");
            print("Project: ${task.project}");
            // Add more fields as needed
          }
          isLoading.value = false;
        } else {
          print("No tasks found."); // Handle the case when there are no tasks
        }
      } catch (e) {
        print("Error fetching task list: $e");
        // Handle the error appropriately
      }
    }
  }

  Future<void> getFilterList(
      String? toDate,
      String? fromDate,
      List<String>? projects,
      List<String>? assignees,
      String? statuses,
      String? billable) async {
    if (true) {
      print("filter api call???????????");
      try {
        List<TaskListResponseModel> filterTaskList =
            await APIManager.getFilteredTsk(
                fromDate: fromDate,
                toDate: toDate,
                projects: projects,
                assignees: assignees,
                statuses: statuses,
                billable: billable);

        if (filterTaskList.isNotEmpty) {
          for (var task in filterTaskList) {
            print("Task ID: ${task.id}");

            // Add more fields as needed
          }
          setTaskList(filterTaskList);
          updateFetchedData();
        } else {
          print("No tasks found.");
          getAllTaskList();
          Get.snackbar(
            "No tasks found for the specified criteria.",
            "",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          ); // Handle the case when there are no tasks
        }
      } catch (e) {
        print("Error fetching task list: $e");
        // Handle the error appropriately
      }
    }
  }

  Future<void> getAllStaffNamesList() async {
    try {
      staffLIst.value = await APIManager.getAllStaffNames();

      if (staffLIst.isNotEmpty) {
        print("name list ////////////////////////////////////////${staffLIst}");
      } else {
        print("No list found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error fetching task list: $e");
      // Handle the error appropriately
    }
  }

  Future<void> getAllProjectNameList() async {
    try {
      projectNameList.value = await APIManager.getAllProjectNames();

      if (projectNameList.isNotEmpty) {
        print(
            "name list ////////////////////////////////////////${projectNameList}");
      } else {
        print("No list found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error fetching task list: $e");
      // Handle the error appropriately
    }
  }

  Future<void> updateTask(
      int id,
      String date,
      String project,
      String assignee,
      String task,
      String comments,
      int originalEst,
      int completedHr,
      String status,
      int billableHr,
      String billable) async {
    try {
      String updateResponse = await APIManager.updateTask(
          id,
          date,
          project,
          assignee,
          task,
          comments,
          originalEst,
          completedHr,
          status,
          billableHr,
          billable);

      if (updateResponse.isNotEmpty) {
        print("put response test22 :${updateResponse}");

        getAllTaskList();
      } else {
        print("No tasks found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error update task : $e");
      // Handle the error appropriately
    }
  }

  Future<void> updateProjectNameInTask(
    int id,
    String project,
  ) async {
    try {
      String projectInTaskUpdateResponse = await APIManager.updateProjectInTask(
        id,
        project,
      );

      if (projectInTaskUpdateResponse.isNotEmpty) {
        print("put response test22 :${projectInTaskUpdateResponse}");

        getAllTaskList();
      } else {
        print("No tasks found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error update task : $e");
      // Handle the error appropriately
    }
  }

  Future<void> updateAssigneeNameInTask(
    int id,
    String assignee,
  ) async {
    try {
      String assigneeInTaskUpdateResponse =
          await APIManager.updateAssigneeInTask(
        id,
        assignee,
      );

      if (assigneeInTaskUpdateResponse.isNotEmpty) {
        print("put response test22 :${assigneeInTaskUpdateResponse}");
        getAllTaskList();
      } else {
        print("No tasks found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error update task : $e");
      // Handle the error appropriately
    }
  }

  Future<void> updateBillableInTask(
    int id,
    String project,
  ) async {
    try {
      String billableInTaskUpdateResponse = await APIManager.updateBillInTask(
        id,
        project,
      );

      if (billableInTaskUpdateResponse.isNotEmpty) {
        print("put response test22 :${billableInTaskUpdateResponse}");
        getAllTaskList();
      } else {
        print("No tasks found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error update task : $e");
      // Handle the error appropriately
    }
  }

  Future<void> deleteTasks(
    int id,
  ) async {
    try {
      String deleteResponse = await APIManager.deleteTask(
        id,
      );

      if (deleteResponse.isNotEmpty) {
        print("delete response test22 :${deleteResponse}");

        getAllTaskList();
      } else {
        print("No tasks found."); // Handle the case when there are no tasks
      }
    } catch (e) {
      print("Error update task : $e");
      // Handle the error appropriately
    }
  }

  void updateFetchedData() {
    if (isFilter.isTrue) {
      print("000000000000");
      print(filterTaskList);
      fetchedData.assignAll(filterTaskList.map((taskListResponseModel) {
        return TaskModel(
          id: taskListResponseModel.id,
          date: taskListResponseModel.date,
          project: taskListResponseModel.project,
          assignee: taskListResponseModel.assignee,
          task: taskListResponseModel.task,
          comments: taskListResponseModel.comments,
          originalEst: taskListResponseModel.originalEst,
          completedHr: taskListResponseModel.completedHr,
          status: taskListResponseModel.status,
          billableHr: taskListResponseModel.billableHr,
          billable: taskListResponseModel.billable,

          // Map other properties as needed
        );
      }).toList());
    } else {
      fetchedData.assignAll(taskList.map((taskListResponseModel) {
        return TaskModel(
          id: taskListResponseModel.id,
          date: taskListResponseModel.date,
          project: taskListResponseModel.project,
          assignee: taskListResponseModel.assignee,
          task: taskListResponseModel.task,
          comments: taskListResponseModel.comments,
          originalEst: taskListResponseModel.originalEst,
          completedHr: taskListResponseModel.completedHr,
          status: taskListResponseModel.status,
          billableHr: taskListResponseModel.billableHr,
          billable: taskListResponseModel.billable,

          // Map other properties as needed
        );
      }).toList());
    }
    print(
        "Fetched Data****************************************************************************: $fetchedData");
  }
}

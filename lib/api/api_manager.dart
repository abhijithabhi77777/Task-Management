import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:task_management_web_app/models/login_response_model.dart';
import 'package:task_management_web_app/models/project_added_response.dart';
import 'package:task_management_web_app/models/project_count_response.dart';
import 'package:task_management_web_app/models/staff_count_response.dart';
import 'package:task_management_web_app/models/staff_created_response.dart';
import 'package:task_management_web_app/models/task_adding_response.dart';

import '../models/task_table_response_model.dart';
import 'api_network_helper.dart';

class APIManager {
  static const String baseUrl =
      "http://localhost:8080"; //"http://192.168.1.72:8080/api/login/login";

  static const String userLogin = "$baseUrl/api/login/login";
  static const String staffAdding = "$baseUrl/api/staffs/addStaff";
  static const String staffCount = "$baseUrl/api/staffs/count";
  static const String projectCount = "$baseUrl/api/projects/projectCount";
  static const String taskAdding = "$baseUrl/api/tasks/addTask";
  static const String getAllTasks = "$baseUrl/api/tasks/allTasks";
  static const String getFilteredTaskUrl = "$baseUrl/api/tasks?";
  static const String putUpdateTasks = "$baseUrl/api/tasks/";
  static const String putUpdateProjectInTask = "$baseUrl/api/tasks/";
  static const String putUpdateAssigneeInTask = "$baseUrl/api/tasks/";
  static const String putUpdateBillInTask = "$baseUrl/api/tasks/";
  static const String deleteTasks = "$baseUrl/api/tasks/";
  static const String getAllTaskNamesUrl = "$baseUrl/api/staffs/allStaffNames";
  static const String getAllProjectsNameUrl =
      "$baseUrl/api/projects/allProjectNames";
  static const String projectAdding = "$baseUrl/api/projects/addProject";

  static Future<dynamic> getLogin(String mailId, String password) async {
    const url = userLogin;
    final body = {
      "email_id": mailId,
      "password": password,
    };

    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);
      print('Response000: $response');
      if (response.statusCode == 200) {
        LoginResponseModel? loginResponseModel =
            LoginResponseModel.fromJson(response.data);

        if (loginResponseModel.message == "Login successful") {
          return loginResponseModel;
        } else {
          return "Invalid credentials"; // Return an error message
        }
      } else {
        final errorMessage = response.data;
        print('Error22: $errorMessage');
        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error010: $e');
      return (e);
    }
  }

  static Future<dynamic> addStaff(
      String staffName,
      String mailId,
      String password,
      String position,
      String role,
      String employeeId,
      String employeeType,
      String avatarName) async {
    const url = staffAdding;
    final body = {
      "staff_name": staffName,
      "email_id": mailId,
      "password": password,
      "position": position,
      "role": role,
      "employee_id": employeeId,
      "employee_type": employeeType,
      "avatar_id": avatarName
    };

    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        StaffCreatedResponse? staffCreatedResponse =
            StaffCreatedResponse.fromJson(response.data);

        if (staffCreatedResponse.message.isNotEmpty) {
          return staffCreatedResponse;
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> addProject(
    String clientName,
    String projectName,
    String? projectDescription,
  ) async {
    const url = projectAdding;
    final body = {
      "client_name": clientName,
      "project_name": projectName,
      "project_description": projectDescription,
    };

    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        ProjectAddedResponse? projectAddedResponse =
            ProjectAddedResponse.fromJson(response.data);

        if (projectAddedResponse.message.isNotEmpty) {
          return projectAddedResponse;
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> getStaffCount() async {
    const url = staffCount;
    // final body = {
    //   "email_id": mailId,
    //   "password": password,
    // };

    try {
      final response = await NetworkHelper().getWithParams(
        url: url,
      );

      if (response.statusCode == 200) {
        // Successful login

        StaffCountResponse? staffCountResponse =
            StaffCountResponse.fromJson(response.data);

        if (staffCountResponse.totalStaffCount > 0) {
          return staffCountResponse;
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> getProjectCount() async {
    const url = projectCount;
    // final body = {
    //   "email_id": mailId,
    //   "password": password,
    // };

    try {
      final response = await NetworkHelper().getWithParams(url: url);

      if (response.statusCode == 200) {
        // Successful login

        ProjectCountResponse? projectCountResponse =
            ProjectCountResponse.fromJson(response.data);

        if (projectCountResponse.totalProjectCount > 0) {
          return projectCountResponse;
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> addTask(
    String date,
    String project,
    String assignee,
    String task,
    String comments,
    int originalEst,
    int completedHr,
    String status,
    int billableHrs,
    String billable,
  ) async {
    const url = taskAdding;
    final body = {
      "date": date,
      "project": project,
      "assignee": assignee,
      "task": task,
      "comments": comments,
      "original_est": originalEst,
      "completed_hr": completedHr,
      "status": status,
      "billable_hr": billableHrs,
      "billable": billable
    };

    try {
      final response = await NetworkHelper().postWithBody(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        TaskAddingResponse? taskAddingResponse =
            TaskAddingResponse.fromJson(response.data);

        if (taskAddingResponse.message.isNotEmpty) {
          return taskAddingResponse;
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<List<TaskListResponseModel>> getAllTask() async {
    const url = getAllTasks;

    try {
      final response = await NetworkHelper().getWithParams(url: url);

      if (response.statusCode == 200) {
        // Successful adding
        print(" Successful 1111111111111111111111111111111");
        List<Map<String, dynamic>> taskListJson =
            List<Map<String, dynamic>>.from(response.data);

        List<TaskListResponseModel> taskList = taskListJson
            .map((json) => TaskListResponseModel.fromJson(json))
            .toList();
        print("taskList[0]22222222222222222222");
        return taskList;
      } else {
        // otp failed
        // Handle error response here if needed
        final errorMessage = response.data;
        print(errorMessage);
        return [];
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
      return [];
    }
  }

  static Future<List<TaskListResponseModel>> getFilteredTsk({
    String? fromDate,
    String? toDate,
    List<String>? projects,
    List<String>? assignees,
    String? statuses,
    String? billable,
  }) async {
    const url = getFilteredTaskUrl;

    try {
      final queryParameters = {
        if (fromDate != null) 'fromDate': toDate,
        // DateFormat("yyyy-MM-dd").parse(fromDate),
        if (toDate != null) 'toDate': fromDate,
        //DateFormat("yyyy-MM-dd").parse(toDate),
        if (projects != []) 'project': projects!.join(','),
        // // // Convert list to comma-separated string
        if (assignees != []) 'assignee': assignees!.join(','),
        // // // Convert list to comma-separated string
        if (statuses != null && statuses != 'All Statuses')
          'statuse': statuses.toString(),
        // // Convert list to comma-separated string
        if (billable != null) 'billable': billable,
      };

      final response = await NetworkHelper().getWithParams(
        url: url,
        parameterMap: queryParameters,
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> taskListJson =
            List<Map<String, dynamic>>.from(response.data);

        List<TaskListResponseModel> taskList = taskListJson
            .map((json) => TaskListResponseModel.fromJson(json))
            .toList();

        return taskList;
      } else {
        final errorMessage = response.data;
        print(errorMessage);
        print('ErrorErrorErrorErrorErrorErrorErrorErrorError: ');
        return [];
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error: $e');
      print((e.toString()));

      return [];
    }
  }

  static Future<dynamic> updateTask(
    int id,
    String date,
    String project,
    String assignee,
    String task,
    String comments,
    int originalEst,
    int completedHr,
    String status,
    int billableHrs,
    String billable,
  ) async {
    final url = "$putUpdateTasks$id";
    final body = {
      "date": date,
      "project": project,
      "assignee": assignee,
      "task": task,
      "comments": comments,
      "original_est": originalEst,
      "completed_hr": completedHr,
      "status": status,
      "billable_hr": billableHrs,
      "billable": billable
    };

    try {
      final response =
          await NetworkHelper().putWithParams(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        String? taskUpdateResponse = (response.data);
        print("put response test11 :${taskUpdateResponse}");
        if (taskUpdateResponse == "Task updated successfully") {
          print("put response test :${taskUpdateResponse}");
          return taskUpdateResponse;
        } else {
          print("put response test 333 :${taskUpdateResponse}");
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> updateProjectInTask(
    int id,
    String project,
  ) async {
    final url = "$putUpdateProjectInTask$id";
    final body = {
      "project": project,
    };

    try {
      final response =
          await NetworkHelper().putWithParams(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        String? projectInTaskUpdateResponse = (response.data);
        print("project update response :${projectInTaskUpdateResponse}");
        if (projectInTaskUpdateResponse == "Task updated successfully") {
          return projectInTaskUpdateResponse;
        } else {
          print(
              "project In Task Update Response :${projectInTaskUpdateResponse}");
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> updateAssigneeInTask(
    int id,
    String assignee,
  ) async {
    final url = "$putUpdateAssigneeInTask$id";
    final body = {
      "assignee": assignee,
    };

    try {
      final response =
          await NetworkHelper().putWithParams(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        String? assigneeInTaskUpdateResponse = (response.data);
        print("project update response :${assigneeInTaskUpdateResponse}");
        if (assigneeInTaskUpdateResponse == "Task updated successfully") {
          return assigneeInTaskUpdateResponse;
        } else {
          print(
              "assignee In Task Update Response :${assigneeInTaskUpdateResponse}");
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> updateBillInTask(
    int id,
    String bill,
  ) async {
    final url = "$putUpdateBillInTask$id";
    final body = {
      "billable": bill,
    };

    try {
      final response =
          await NetworkHelper().putWithParams(url: url, body: body);

      if (response.statusCode == 200) {
        // Successful adding

        String? billInTaskUpdateResponse = (response.data);
        print("bill update response :${billInTaskUpdateResponse}");
        if (billInTaskUpdateResponse == "Task updated successfully") {
          return billInTaskUpdateResponse;
        } else {
          print("bill In Task Update Response :${billInTaskUpdateResponse}");
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<dynamic> deleteTask(
    int id,
  ) async {
    final url = "$deleteTasks$id";

    try {
      final response = await NetworkHelper().delete(url: url);

      if (response.statusCode == 200) {
        // Successful adding

        String? taskDeleteResponse = (response.data);

        if (taskDeleteResponse == "Task deleted successfully") {
          return taskDeleteResponse;
        } else {
          print("Delete response  :${taskDeleteResponse}");
        }
      } else {
        // otp failed
        final errorMessage = response.data;
        // Display error message or handle accordingly

        return errorMessage;
      }
    } on DioException catch (e) {
      log(e.toString());

      print('Error: $e');
    }
  }

  static Future<List<String>> getAllStaffNames() async {
    const url = getAllTaskNamesUrl;
    try {
      final response = await NetworkHelper().getWithParams(url: url);

      if (response.statusCode == 200) {
        List<String> taskList = List<String>.from(response.data);
        return taskList;
      } else {
        final errorMessage = response.data;
        print(errorMessage);
        // Return an empty list or handle the error as needed
        return <String>[];
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error: $e');
      // Return an empty list or handle the error as needed
      return <String>[];
    }
  }

  static Future<List<String>> getAllProjectNames() async {
    const url = getAllProjectsNameUrl;
    try {
      final response = await NetworkHelper().getWithParams(url: url);

      if (response.statusCode == 200) {
        List<String> projectList = List<String>.from(response.data);
        return projectList;
      } else {
        final errorMessage = response.data;
        print(errorMessage);
        // Return an empty list or handle the error as needed
        return <String>[];
      }
    } on DioException catch (e) {
      log(e.toString());
      print('Error: $e');
      // Return an empty list or handle the error as needed
      return <String>[];
    }
  }
}

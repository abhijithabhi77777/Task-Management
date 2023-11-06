import 'package:get/get.dart';

class TaskModel extends GetxController {
  int id;
  String date;
  String project;
  String assignee;
  String? task;
  String? comments;
  int? originalEst;
  int? completedHr;
  String status;
  int? billableHr;
  String billable;

  // bool isEditing; // Add isEditing flag
  Rx<String> projectValueControllerFetchedData =
      Rx<String>(''); // Separate controller for 'Project' dropdown
  Rx<String> nameValueController =
      Rx<String>(''); // Separate controller for 'Assignee' dropdown
  Rx<String> billableValueController = Rx<String>('');

  final RxBool isEditing = false.obs;

  void toggleEdit() {
    print(isEditing.value);
    isEditing.value = !isEditing.value;
    print(isEditing.value);
  }

  TaskModel({
    required this.id,
    required this.date,
    required this.project,
    required this.assignee,
    this.task,
    this.comments,
    this.originalEst,
    this.completedHr,
    required this.status,
    this.billableHr,
    required this.billable,
    // this.isEditing = false, // Initialize isEditing to false by default
  });
}

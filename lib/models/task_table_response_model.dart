class TaskListResponseModel {
  final int id;
  final String date;
  final String project;
  final String assignee;
  final String? task;
  final String? comments;
  final int originalEst;
  final int completedHr;
  final String status;
  final int billableHr;
  final String billable;
  final String createdAt;
  final String updatedAt;
  bool? isEditing; // Add isEditing flag

  TaskListResponseModel({
    required this.id,
    required this.date,
    required this.project,
    required this.assignee,
    this.task,
    this.comments,
    required this.originalEst,
    required this.completedHr,
    required this.status,
    required this.billableHr,
    required this.billable,
    required this.createdAt,
    required this.updatedAt,
    this.isEditing = false,
  });

// Constructor for TaskListResponseModel
  TaskListResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        project = json['project'],
        assignee = json['assignee'],
        task = json['task'],
        comments = json['comments'],
        originalEst = json['original_est'],
        completedHr = json['completed_hr'],
        status = json['status'],
        billableHr = json['billable_hr'],
        billable = json['billable'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

}

// Convert JSON data to a list of TaskListResponseModel objects
List<TaskListResponseModel> taskItemsFromJson(
    List<Map<String, dynamic>> jsonList) {
  return jsonList.map((json) => TaskListResponseModel.fromJson(json)).toList();
}

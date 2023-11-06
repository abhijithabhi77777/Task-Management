class TaskAddingResponse {
  final String message;
  final int id;
  final String project;
  final String task;
  final String assignee;

  TaskAddingResponse({
    required this.message,
    required this.id,
    required this.project,
    required this.task,
    required this.assignee,
  });

  factory TaskAddingResponse.fromJson(Map<String, dynamic> json) {
    return TaskAddingResponse(
      message: json['message'],
      id: json['id'],
      project: json['project'],
      task: json['task'],
      assignee: json['assignee'],
    );
  }
}

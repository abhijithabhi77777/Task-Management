class ProjectAddedResponse {
  final String message;
  final int id;
  final String projectName;

  ProjectAddedResponse({
    required this.message,
    required this.id,
    required this.projectName,
  });

  factory ProjectAddedResponse.fromJson(Map<String, dynamic> json) {
    return ProjectAddedResponse(
      message: json['message'],
      id: json['id'],
      projectName: json['project_name'],
    );
  }
}

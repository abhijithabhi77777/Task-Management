class StaffCreatedResponse {
  final String message;
  final int id;
  final String staffName;

  StaffCreatedResponse({
    required this.message,
    required this.id,
    required this.staffName,
  });

  factory StaffCreatedResponse.fromJson(Map<String, dynamic> json) {
    return StaffCreatedResponse(
      message: json['message'] as String,
      id: json['id'] as int,
      staffName: json['staff_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'id': id,
      'staff_name': staffName,
    };
  }
}

class LoginResponseModel {
  String message;
  int id;
  String staffName; // Renamed from staff_name
  String emailId; // Renamed from email_id
  String position;
  String avatarId;

  LoginResponseModel(
      {required this.message,
      required this.id,
      required this.staffName,
      required this.emailId,
      required this.position,
      required this.avatarId});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      id: json['id'],
      staffName: json['staff_name'],
      emailId: json['email_id'],
      position: json['position'],
      avatarId: json['avatar_id'],
    );
  }

  LoginResponseModel? fromJson(data) {}
}

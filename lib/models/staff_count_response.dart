import 'package:get/get.dart';

class StaffCountResponse {
  final int totalStaffCount;

  StaffCountResponse({required this.totalStaffCount});

  factory StaffCountResponse.fromJson(Map<String, dynamic> json) {
    return StaffCountResponse(totalStaffCount: json['totalStaffCount'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalStaffCount': totalStaffCount,
    };
  }
}

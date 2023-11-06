import 'package:get/get.dart';

class ProjectCountResponse {
  final int totalProjectCount;

  ProjectCountResponse({required this.totalProjectCount});

  factory ProjectCountResponse.fromJson(Map<String, dynamic> json) {
    return ProjectCountResponse(
        totalProjectCount: json['totalProjectCount'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalProjectCount': totalProjectCount,
    };
  }
}

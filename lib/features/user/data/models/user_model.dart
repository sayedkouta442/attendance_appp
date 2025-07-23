class UserModel {
  final String userId;
  final String fullName;
  final String? imageUrl;
  final String jobTitle;
  final String department;
  final String email;
  final String phoneNumber;
  final DateTime joinDate;
  final String branch;

  UserModel({
    required this.userId,
    required this.fullName,
    this.imageUrl,
    required this.jobTitle,
    required this.department,
    required this.email,
    required this.phoneNumber,
    required this.joinDate,
    required this.branch,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] as String,
      fullName: json['full_name'] as String,
      jobTitle: json['job_title'] as String,
      department: json['departments']['name'] as String,

      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      joinDate: json['join_date'] != null
          ? DateTime.parse(json['join_date'] as String)
          : DateTime.now(),
      branch: json['branches']['name'] as String,

      imageUrl: json['image_url'] as String? ?? '',
    );
  }
}

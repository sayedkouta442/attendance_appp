class SupabaseFaceDataModel {
  final String id;
  final String employeeId;
  final String faceImageUrl;

  SupabaseFaceDataModel({
    required this.id,
    required this.employeeId,
    required this.faceImageUrl,
  });

  factory SupabaseFaceDataModel.fromJson(Map<String, dynamic> json) {
    return SupabaseFaceDataModel(
      id: json['id'],
      employeeId: json['employee_id'],
      faceImageUrl: json['face_image_url'],
    );
  }
}

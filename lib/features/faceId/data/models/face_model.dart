import 'package:flutter/material.dart';

class FaceModel {
  final int id;
  final Rect boundingBox;
  final Map<FaceLandmarkType, Offset?> landmarks;
  final String imagePath;

  FaceModel({
    required this.id,
    required this.boundingBox,
    required this.landmarks,
    required this.imagePath,
  });
}

// Enum for face landmark types
enum FaceLandmarkType {
  leftEye,
  rightEye,
  nose,
  bottomMouth,
  leftCheek,
  rightCheek,
}

// Result class for face recognition
class FaceRecognitionResult {
  final bool success;
  final String message;
  final int matchedFaceId;
  final double confidence;

  FaceRecognitionResult({
    required this.success,
    required this.message,
    required this.matchedFaceId,
    required this.confidence,
  });
}

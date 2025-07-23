import 'dart:io';

import 'dart:math' as math;
import 'package:attendance_appp/features/record_attendance/data/data_sources/attendance_remote_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'
    as ml_kit;

// import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../models/face_model.dart';

class FaceRecognitionService {
  final RecordAttendanceRemoteDataSourceImpl attendanceImage;
  final ml_kit.FaceDetector _faceDetector = ml_kit.FaceDetector(
    options: ml_kit.FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      enableTracking: false,
      performanceMode: ml_kit.FaceDetectorMode.accurate,
    ),
  );

  List<FaceModel> _referenceFaces = [];
  bool _isInitialized = false;

  FaceRecognitionService(this.attendanceImage);

  Future<void> initialize() async {
    if (_isInitialized) return;

    _referenceFaces = [];

    final imageUrl = await attendanceImage.fetchUserImageUrl();
    if (imageUrl == null) {
      print('No face image found for user$imageUrl');
      return;
    }
    try {
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(imageUrl));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(response);

      // Write to temp file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${imageUrl.split('/').last}');
      await tempFile.writeAsBytes(bytes);

      final inputImage = ml_kit.InputImage.fromFilePath(tempFile.path);

      final List<ml_kit.Face> faces = await _faceDetector.processImage(
        inputImage,
      );

      if (faces.isNotEmpty) {
        final ml_kit.Face detectedFace = faces.first;

        final FaceModel faceModel = FaceModel(
          id: _referenceFaces.length,
          boundingBox: detectedFace.boundingBox,
          landmarks: {
            FaceLandmarkType.leftEye: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.leftEye,
            ),
            FaceLandmarkType.rightEye: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.rightEye,
            ),
            FaceLandmarkType.nose: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.noseBase,
            ),
            FaceLandmarkType.bottomMouth: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.bottomMouth,
            ),
            FaceLandmarkType.leftCheek: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.leftCheek,
            ),
            FaceLandmarkType.rightCheek: _getLandmarkPosition(
              detectedFace,
              ml_kit.FaceLandmarkType.rightCheek,
            ),
          },
          imagePath: imageUrl,
        );

        _referenceFaces.add(faceModel);
      }
    } catch (e) {
      print('Error processing reference image $imageUrl: $e');
    }

    _isInitialized = true;
  }

  Offset? _getLandmarkPosition(ml_kit.Face face, ml_kit.FaceLandmarkType type) {
    final landmark = face.landmarks[type];
    if (landmark == null) return null;
    final position = landmark.position;
    if (position == null) return null;
    return Offset(position.x.toDouble(), position.y.toDouble());
  }

  Future<FaceRecognitionResult> compareFace(File imageFile) async {
    if (!_isInitialized) await initialize();

    try {
      final inputImage = ml_kit.InputImage.fromFilePath(imageFile.path);

      final List<ml_kit.Face> faces = await _faceDetector.processImage(
        inputImage,
      );

      if (faces.isEmpty) {
        return FaceRecognitionResult(
          success: false,
          message: 'No face detected in the image',
          matchedFaceId: -1,
          confidence: 0.0,
        );
      }

      final ml_kit.Face capturedFace = faces.first;

      final FaceModel capturedFaceModel = FaceModel(
        id: -1,
        boundingBox: capturedFace.boundingBox,
        landmarks: {
          FaceLandmarkType.leftEye: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.leftEye,
          ),
          FaceLandmarkType.rightEye: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.rightEye,
          ),
          FaceLandmarkType.nose: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.noseBase,
          ),
          FaceLandmarkType.bottomMouth: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.bottomMouth,
          ),
          FaceLandmarkType.leftCheek: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.leftCheek,
          ),
          FaceLandmarkType.rightCheek: _getLandmarkPosition(
            capturedFace,
            ml_kit.FaceLandmarkType.rightCheek,
          ),
        },
        imagePath: imageFile.path,
      );

      FaceRecognitionResult bestMatch = FaceRecognitionResult(
        success: false,
        message: 'No match found',
        matchedFaceId: -1,
        confidence: 0.0,
      );

      for (FaceModel referenceFace in _referenceFaces) {
        double similarity = _calculateFaceSimilarity(
          capturedFaceModel,
          referenceFace,
        );

        const double similarityThreshold = 0.8; //

        if (similarity > similarityThreshold &&
            similarity > bestMatch.confidence) {
          bestMatch = FaceRecognitionResult(
            success: true,
            message: 'Face recognized',
            matchedFaceId: referenceFace.id,
            confidence: similarity,
          );
        }
      }

      return bestMatch;
    } catch (e) {
      return FaceRecognitionResult(
        success: false,
        message: 'Error during face comparison: $e',
        matchedFaceId: -1,
        confidence: 0.0,
      );
    }
  }

  double _calculateFaceSimilarity(FaceModel face1, FaceModel face2) {
    double landmarkSimilarity = 0.0;
    int landmarkCount = 0;

    face1.landmarks.forEach((type, point1) {
      final point2 = face2.landmarks[type];
      if (point1 != null && point2 != null) {
        final dx = point1.dx - point2.dx;
        final dy = point1.dy - point2.dy;
        final distance = sqrt(dx * dx + dy * dy);

        final faceSize1 = face1.boundingBox.width + face1.boundingBox.height;
        final faceSize2 = face2.boundingBox.width + face2.boundingBox.height;
        final avgFaceSize = (faceSize1 + faceSize2) / 2;

        final pointSimilarity = 1.0 - (distance / avgFaceSize);

        landmarkSimilarity += pointSimilarity;
        landmarkCount++;
      }
    });

    return landmarkCount > 0 ? landmarkSimilarity / landmarkCount : 0.0;
  }

  double sqrt(double value) {
    return value <= 0 ? 0 : math.sqrt(value);
  }

  bool isImageQualitySufficient(FaceModel faceModel) {
    bool hasEssentialLandmarks =
        faceModel.landmarks[FaceLandmarkType.leftEye] != null &&
        faceModel.landmarks[FaceLandmarkType.rightEye] != null &&
        faceModel.landmarks[FaceLandmarkType.nose] != null;

    bool hasSufficientSize =
        faceModel.boundingBox.width > 100 && faceModel.boundingBox.height > 100;

    return hasEssentialLandmarks && hasSufficientSize;
  }

  static void showFaceRecognitionResult(
    BuildContext context,
    FaceRecognitionResult result,
  ) {
    final String message = result.success
        ? 'recoginized with${(result.confidence * 100).toStringAsFixed(1)}%'
        : result.message;

    final Color backgroundColor = result.success ? Colors.green : Colors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void dispose() {
    _faceDetector.close();
  }
}

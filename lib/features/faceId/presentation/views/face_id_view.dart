import 'dart:io';
import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/faceId/data/services/face_id_service.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

class FaceRecognitionView extends StatefulWidget {
  const FaceRecognitionView({super.key});

  @override
  State<FaceRecognitionView> createState() => _FaceRecognitionViewState();
}

class _FaceRecognitionViewState extends State<FaceRecognitionView> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  bool isCameraInitialized = false;
  bool isProcessing = false;
  FaceService faceService = FaceService();

  @override
  void initState() {
    super.initState();
    initializeCamera();
    initializeFaceService();
  }

  Future<void> initializeFaceService() async {
    await faceService.initialize();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Camera available'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller!.initialize();

      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('error when initialize camera: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> takePicture() async {
    if (!isCameraInitialized || isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      final XFile image = await controller!.takePicture();
      final File imageFile = File(image.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('image proccessing......'),
          duration: Duration(seconds: 1),
        ),
      );

      final result = await faceService.compareFace(imageFile);

      if (result.success && result.confidence >= 0.75) {
        // ignore: use_build_context_synchronously
        GoRouter.of(context).push(AppRouter.kSuccessView);
      } else {
        // Show result with Snackbar
        FaceService.showFaceRecognitionResult(context, result);
      }
    } catch (e) {
      print('Error taking picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error when take picture: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    faceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: const Text(
          'Face Recognition',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: isCameraInitialized
                ? CameraPreview(controller!)
                : const Center(child: CircularProgressIndicator()),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: isProcessing ? null : takePicture,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color(0xff3662e1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Take picture for recognition',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Ensure the clarity of the face in the frame and good lighting for best results',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

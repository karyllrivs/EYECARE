import 'dart:io';
import 'package:eyecare_mobile/pages/virtual_try_on/painter/face_detector_painter.dart';
import 'package:eyecare_mobile/shared/helpers/image_utils.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:camera/camera.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final String imageFilename;
  const CameraView({super.key, required this.imageFilename});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  FaceDetector? faceDetector;

  CustomPaint? customPaint;

  bool isDetecting = false;

  int cameraIndex = 0;

  Future<void> initializedCameras() async {
    cameras = await availableCameras();
    CameraDescription camera = cameras[cameraIndex];

    controller = CameraController(
      camera, ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );
    controller!.initialize().then((_) async {
      if (!mounted) {
        return;
      }
      setState(() {
        isDetecting = false;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // ignore: use_build_context_synchronously
            showResultDialog(context, false, message: "Camera Access Denied");
            break;
          default:
            showResultDialog(context, false, message: e.description);
            break;
        }
      }
    });
  }

  void initializedFaceDetector() async {
    final options = FaceDetectorOptions(
        enableLandmarks: true, performanceMode: FaceDetectorMode.fast);
    faceDetector = FaceDetector(options: options);
  }

  Future<void> startDetection() async {
    debugPrint("Start detection...");
    setState(() {
      isDetecting = true;
    });
    if (controller!.value.isStreamingImages) {
      return;
    }

    await controller!.startImageStream((image) async {
      if (isDetecting) {
        detectImageFromFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
    if (controller!.value.isStreamingImages) {
      controller!.stopImageStream();
    }
    setState(() {
      isDetecting = false;
    });
    debugPrint("Detection stopped.");
  }

  Future<void> detectImageFromFrame(CameraImage cameraImage) async {
    final camera = cameras[0];

    InputImage? inputImage = ImageUtils.convertCameraImageToInputImage(
        controller!, camera, cameraImage);

    if (inputImage == null) return;

    final List<Face> faces = await faceDetector!.processImage(inputImage);

    updateCustomPaint(faces, inputImage);
  }

  void updateCustomPaint(List<Face> faces, InputImage inputImage) async {
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final image = await ImageUtils.convertToUIImage(widget.imageFilename);
      final painter = FaceDetectorPainter(
        image,
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        CameraLensDirection.front,
      );

      setState(() {
        customPaint = CustomPaint(painter: painter);
      });
    }
  }

  void switchCamera() {
    setState(() {
      cameraIndex = cameraIndex == 0 ? 1 : 0;
    });
  }

  @override
  void initState() {
    initializedCameras();
    initializedFaceDetector();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    faceDetector!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQueryDataSize = MediaQuery.of(context).size;

    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: mediaQueryDataSize.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: CameraPreview(
              controller!,
              child: isDetecting ? customPaint : const SizedBox(),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Row(children: [
                isDetecting
                    ? IconButton(
                        onPressed: () async {
                          stopDetection();
                        },
                        icon: const Icon(
                          Icons.stop,
                          color: Colors.red,
                        ),
                        iconSize: 50,
                      )
                    : IconButton(
                        onPressed: () async {
                          await startDetection();
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        iconSize: 50,
                      ),
                cameras.length > 2
                    ? IconButton(
                        onPressed: () async {
                          switchCamera();
                        },
                        icon: const Icon(
                          Icons.switch_camera,
                          color: Colors.red,
                        ),
                        iconSize: 50,
                      )
                    : const SizedBox(),
              ])),
        ],
      ),
    );
  }
}

import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.image,
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final ui.Image image;
  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) async {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = Colors.green;

    for (final Face face in faces) {
      final leftEyeLandmark = face.landmarks[FaceLandmarkType.leftEye];
      final rightEyeLandmark = face.landmarks[FaceLandmarkType.rightEye];

      if (leftEyeLandmark != null && rightEyeLandmark != null) {
        final leftEyePositionX = translatePositionX(
          leftEyeLandmark.position.x.toDouble(),
          size,
        );
        final rightEyePositionX = translatePositionX(
          rightEyeLandmark.position.x.toDouble(),
          size,
        );

        final leftEyePositionY = translatePositionY(
          leftEyeLandmark.position.y.toDouble(),
          size,
        );
        final rightEyePositionY = translatePositionY(
          rightEyeLandmark.position.y.toDouble(),
          size,
        );

        double dx = rightEyePositionX - leftEyePositionX;
        double dy = rightEyePositionY - leftEyePositionY;

        // Calculate the eye distance
        double eyeDistance = math.sqrt(dx * dx + dy * dy);

        // Calculate rotation angle
        double angle = math.atan2(dy, dx);

        // Calculate image fitting size
        double imageWidth = eyeDistance * 2; // desired width
        double imageHeight =
            (image.height / image.width) * imageWidth; // desired height

        // Save current canvas state
        canvas.save();

        // Move the canvas origin to the eye center
        canvas.translate(
          getMean(
            leftEyePositionX,
            rightEyePositionX,
          ),
          getMean(
            leftEyePositionY,
            rightEyePositionY,
          ),
        );

        // Rotate the canvas by the calculated angle
        canvas.rotate(angle);

        // Draw the image at the rotated position
        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          Rect.fromCenter(
            center: const Offset(0, 0),
            width: imageWidth,
            height: imageHeight,
          ),
          paint,
        );

        // Restore the canvas state
        canvas.restore();
      }
    }
  }

  double translatePositionX(double value, Size size) {
    return translateX(
      value,
      size,
      imageSize,
      rotation,
      cameraLensDirection,
    );
  }

  double translatePositionY(double value, Size size) {
    return translateY(
      value,
      size,
      imageSize,
      rotation,
      cameraLensDirection,
    );
  }

  double getMean(double v1, double v2) {
    return (v1 + v2) / 2;
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}

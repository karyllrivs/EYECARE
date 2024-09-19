import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ui' as ui;
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';

// ImageUtils
class ImageUtils {
  static InputImage? convertCameraImageToInputImage(
    CameraController controller,
    CameraDescription camera,
    CameraImage cameraImage,
  ) {
    /** Initialized Device Oriendation */
    final orientations = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 90,
      DeviceOrientation.portraitDown: 180,
      DeviceOrientation.landscapeRight: 270,
    };

    debugPrint("Converting");
    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          orientations[controller.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(cameraImage.format.raw);
    if (format == null) {
      debugPrint("Format is null");
      return null;
    }

    final plane = cameraImage.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: format == InputImageFormat.nv21
          ? plane.bytes
          : convertCameraImageToNV21(cameraImage),
      metadata: InputImageMetadata(
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  static Uint8List convertCameraImageToNV21(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    final int ySize = width * height;
    final int uvSize = width * height ~/ 4;

    Uint8List nv21 = Uint8List(ySize + (uvSize * 2));

    // Y plane
    for (int i = 0; i < ySize; i++) {
      nv21[i] = cameraImage.planes[0].bytes[i];
    }

    // UV planes
    int uvIndex = ySize;
    for (int i = 0; i < uvSize; i++) {
      nv21[uvIndex++] = cameraImage.planes[2].bytes[i]; // V
      nv21[uvIndex++] = cameraImage.planes[1].bytes[i]; // U
    }

    return nv21;
  }

  static Future<ui.Image> convertToUIImage(imageFilename) async {
    img.Image? image;
    final response = await http.get(Uri.parse(getFilePath(imageFilename)));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      image = img.decodeImage(bytes);
    } else {
      throw Exception('Failed to load image');
    }

    final imageBytes = Uint8List.fromList(img.encodePng(image!));
    return decodeImageFromList(imageBytes);
  }
}

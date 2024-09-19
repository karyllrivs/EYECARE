import 'package:eyecare_mobile/config/constants.dart';

String getFilePath(String filename) {
  return "${Constants.eyecareApiUrl}/file/$filename";
}

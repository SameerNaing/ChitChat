import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:intl/intl.dart';

class Utilities {
  // ignore: missing_return
  static bool validateEmail(String value) {
    return EmailValidator.validate(value);
  }

  // ignore: missing_return
  static bool checkPassword(String value) {
    return value.length < 6;
  }

  // ignore: missing_return
  static bool conformPassword(String pass, String conform) {
    return pass == conform;
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  static String readableFormat(int numberToFormat) {
    return NumberFormat.compact().format(numberToFormat);
  }
}

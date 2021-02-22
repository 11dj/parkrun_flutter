import 'package:image/image.dart';
import 'dart:io';

Image copyCrop(Image src, int x, int y, int w, int h) {
  // Make sure crop rectangle is within the range of the src image.
  x = x.clamp(0, src.width - 1).toInt();
  y = y.clamp(0, src.height - 1).toInt();
  print('x: $x');
  print('y: $y');
  if (x + w > src.width) {
    w = src.width - x;
  }
  if (y + h > src.height) {
    h = src.height - y;
  }

  var dst =
      Image(w, h, channels: src.channels, exif: src.exif, iccp: src.iccProfile);

  for (var yi = 0, sy = y; yi < h; ++yi, ++sy) {
    for (var xi = 0, sx = x; xi < w; ++xi, ++sx) {
      dst.setPixel(xi, yi, src.getPixel(sx, sy));
    }
  }

  return dst;
}

Image copyCrop2(var src, int x, int y, int w, int h) {
  // Make sure crop rectangle is within the range of the src image.
  x = x.clamp(0, src.width - 1).toInt();
  y = y.clamp(0, src.height - 1).toInt();
  // print('x: $x');
  // print('y: $y');
  // print('src.width ${src.width}');
  // print('src.height ${src.height}');
  if (x + w > src.width) {
    w = src.width - x;
  }
  if (y + h > src.height) {
    h = src.height - y;
  }

  var dst =
      Image(w, h, channels: src.channels, exif: src.exif, iccp: src.iccProfile);

  for (var yi = 0, sy = y; yi < h; ++yi, ++sy) {
    for (var xi = 0, sx = x; xi < w; ++xi, ++sx) {
      dst.setPixel(xi, yi, src.getPixel(sx, sy));
    }
  }

  return dst;
}

Future decodeImg(x) async {
  var src = decodeImage(File(x).readAsBytesSync());
  return src;
}

encodePNG(x) {
  return encodePng(copyRotate(x, 90));
}

import 'dart:developer';
import 'dart:math';

import 'package:image/image.dart';

Image correction2(Image src) {
final stopwatch = Stopwatch()..start();
// iWonderHowLongThisTakes();
  print(src.getBytes().join(","));
  // var pixelsCopy = src.clone();
  var width = src.width;
  var height = src.height;
  var outPut = Image(width, height, channels: src.channels);
  // var outPut = src.clone();

  // parameters for correction
  double paramA = -0.5; // affects only the outermost pixels of the image
  double paramB = 0.4; // most cases only require b optimization
  double paramC = 0.1; // most uniform correction
  double paramD = 1.0 -
      paramA -
      paramB -
      paramC; // describes the linear scaling of the image
  // inspect(src);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int d = min(width, height) ~/ 2; // radius of the circle

      // center of dst image
      double centerX = (width - 1) / 2.0;
      double centerY = (height - 1) / 2.0;

      // cartesian coordinates of the destination point (relative to the centre of the image)
      double deltaX = (x - centerX) / d;
      double deltaY = (y - centerY) / d;

      // distance or radius of dst image
      double dstR = sqrt(deltaX * deltaX + deltaY * deltaY);

      // distance or radius of src image (with formula)
      double srcR = (paramA * dstR * dstR * dstR +
              paramB * dstR * dstR +
              paramC * dstR +
              paramD) *
          dstR;

      // comparing old and new distance to get factor
      double factor = (dstR / srcR).abs();

      // coordinates in source image
      double srcXd = centerX + (deltaX * factor * d);
      double srcYd = centerY + (deltaY * factor * d);

      // no interpolation yet (just nearest point)
      int srcX = srcXd.toInt();
      int srcY = srcYd.toInt();

      if (srcX >= 0 && srcY >= 0 && srcX < width && srcY < height) {
        // int dstPos = y * width + x;
        // print('$x-$y , $srcX-$srcY');
        outPut.setPixel(x, y, src.getPixel(srcX, srcY));
      } else {
        print('not selected');
      }
    }
  }
  print('doSomething() executed in ${stopwatch.elapsed.toString()}');
  stopwatch.stop();
  return outPut;
}

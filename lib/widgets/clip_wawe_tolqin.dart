import 'package:flutter/cupertino.dart';

class WaveClipperTolqin extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.7);

    // 1-to‘lqin
    path.quadraticBezierTo(
      size.width * 0.125, size.height * 0.6,
      size.width * 0.25, size.height * 0.7,
    );

    // 2-to‘lqin
    path.quadraticBezierTo(
      size.width * 0.375, size.height * 0.8,
      size.width * 0.5, size.height * 0.7,
    );

    // 3-to‘lqin
    path.quadraticBezierTo(
      size.width * 0.625, size.height * 0.6,
      size.width * 0.75, size.height * 0.7,
    );

    // 4-to‘lqin
    path.quadraticBezierTo(
      size.width * 0.875, size.height * 0.8,
      size.width, size.height * 0.7,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}

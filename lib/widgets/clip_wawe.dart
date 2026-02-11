import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 1);

    path.quadraticBezierTo(
      size.width / 1.5, size.height,
      size.width, size.height * 0.4,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

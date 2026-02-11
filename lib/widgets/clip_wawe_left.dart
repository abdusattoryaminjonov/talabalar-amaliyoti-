import 'package:flutter/cupertino.dart';

class WaveClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // chap pastdan boshlaymiz
    path.moveTo(0, size.height);

    // o‘rtaga qarab to‘lqin
    path.quadraticBezierTo(
      size.width / 4, size.height * 0.7, // birinchi nuqta
      size.width / 2, size.height * 0.8, // ikkinchi nuqta
    );

    // ikkinchi to‘lqin
    path.quadraticBezierTo(
      size.width * 3 / 4, size.height * 0.9,
      size.width, size.height * 0.6,
    );

    // o‘ng yuqoriga
    path.lineTo(size.width, 0);

    // chap yuqoriga
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

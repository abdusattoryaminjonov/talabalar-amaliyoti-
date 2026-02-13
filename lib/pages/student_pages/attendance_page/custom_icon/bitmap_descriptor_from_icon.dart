import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> bitmapDescriptorFromIcon(
    IconData iconData, {
      Color color = Colors.blue,
      int size = 100,
    }) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final paint = Paint();

  final textPainter = TextPainter(textDirection: TextDirection.ltr);

  textPainter.text = TextSpan(
    text: String.fromCharCode(iconData.codePoint),
    style: TextStyle(
      fontSize: size.toDouble(),
      fontFamily: iconData.fontFamily,
      color: color,
    ),
  );

  textPainter.layout();
  textPainter.paint(canvas, Offset.zero);

  final picture = pictureRecorder.endRecording();
  final image = await picture.toImage(size, size);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

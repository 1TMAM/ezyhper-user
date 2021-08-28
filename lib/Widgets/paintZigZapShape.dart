import 'package:flutter/material.dart';
import 'package:ezhyper/fileExport.dart';
import 'dart:math' as math;

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    paintZigZag(canvas, paint, Offset(1, 97), Offset(200, 100), 100, 4);
  }

  void paintZigZag(Canvas canvas, Paint paint, Offset start, Offset end,
      int zigs, double width) {
    assert(zigs.isFinite);
    assert(zigs > 0);
    canvas.save();
    canvas.translate(start.dx, start.dy);
    end = end - start;
    canvas.rotate(math.atan2(end.dy, end.dx));
    final double length =700;
    final double spacing = length / (zigs * 2.2);
    final Path path = Path()..moveTo(-2.0, 1.0);
    for (int index = 1; index < zigs; index += 1) {
      final double x = (index * 1.5 + 0.5) * spacing;
      final double y = width * ((index % 5.0) * 2.0 - 0.0);
      path.lineTo(x, y);
    }
    path.lineTo(length, 0.0);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



//CustomPaint(
//size: MediaQuery.of(context).size,
//painter: MyPainter(),
//),

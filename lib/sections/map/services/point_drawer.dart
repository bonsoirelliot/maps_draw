import 'dart:typed_data';
import 'dart:ui';

/// Сервис отрисовки точки
class PointDrawer {
  static Future<Uint8List> buildPointAppearance({
    required double radius,
    required Color pointColor,
  }) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    const size = Size(200, 200);

    final fillPaint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;

    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}

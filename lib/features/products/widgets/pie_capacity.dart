import 'package:flutter/material.dart';


class PieCapacity extends StatelessWidget {
  final int used;
  final int capacity;

  const PieCapacity({
    super.key,
    required this.used,
    required this.capacity,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = capacity <= 0 ? 0.0 : (used / capacity).clamp(0.0, 1.0);
    return CustomPaint(
      painter: _DonutPainter(ratio: ratio),
      child: Center(
        child: Text(
          '${used}/${capacity}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double ratio;
  _DonutPainter({required this.ratio});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * 0.15;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.shortestSide - stroke) / 2;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFFE0E0E0)
      ..strokeCap = StrokeCap.round;

    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFF3F51B5)
      ..strokeCap = StrokeCap.round;

    // Фон
    canvas.drawCircle(center, radius, bg);

    // Сектор "занято"
    final sweep = 2 * 3.141592653589793 * ratio;
    final start = -3.141592653589793 / 2; // сверху
    final rectArc = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rectArc, start, sweep, false, fg);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.ratio != ratio;
}

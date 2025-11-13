import 'package:flutter/material.dart';
import 'dart:math';

class WaterTwilightPainter extends CustomPainter {
  final double animationValue; // 0.0 - 1.0 day-night cycle
  WaterTwilightPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final isDay = animationValue <= 0.5; // 0.0-0.5 = day, 0.5-1.0 = night
    double localValue = isDay ? animationValue * 2 : (animationValue - 0.5) * 2;

    /// >>> Background Gradient (Twilight effect)
    final dayColors = [Colors.orange.shade300, Colors.pink.shade300, Colors.blue.shade200,];
    final nightColors = [Colors.indigo.shade900, Colors.blueGrey.shade900, Colors.black,];

    List<Color> bgColors = [];
    for (int i = 0; i < 3; i++) {
      bgColors.add(Color.lerp(dayColors[i], nightColors[i], isDay ? 0 : localValue)!);
    }

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: bgColors,
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    /// >>> Sun or Moon
    final sunColor = Color(0xFFFFEE58);
    final sunGlow = Colors.orange.withValues(alpha: 0.3);

    final celestialPaint = Paint()
      ..shader = RadialGradient(
        colors: [isDay ? sunColor : Colors.white70, isDay ? sunGlow : Colors.grey.shade300.withValues(alpha: 0.3),],
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height * 0.3), radius: 50,));

    double yPosition = size.height * 0.3 + sin(localValue * pi) * 80;
    canvas.drawCircle(
      Offset(size.width / 2, yPosition),
      40,
      celestialPaint,
    );

    /// >>> Water Ripple Effect
    final ripplePaint = Paint()
      ..color = Colors.white.withValues(alpha : isDay ? 0.2 : 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final radius = 30 + localValue * 100 + i * 50;
      canvas.drawCircle(
        Offset(size.width / 2, size.height * 0.8),
        radius % (size.width / 2),
        ripplePaint,
      );
    }
  }
  @override
  bool shouldRepaint(covariant WaterTwilightPainter oldDelegate) => true;
}



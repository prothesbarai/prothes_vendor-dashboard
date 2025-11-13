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





/*class WaterTwilightPainter extends CustomPainter {
  final double animationValue; // 0.0 - 1.0 day-night cycle
  WaterTwilightPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final isDay = animationValue <= 0.5;
    double localValue = isDay ? animationValue * 2 : (animationValue - 0.5) * 2;

    /// >>> Background Gradient (Twilight effect)
    final dayColors = [
      Colors.orange.shade200,
      Colors.yellow.shade100,
      Colors.lightBlue.shade200,
    ];
    final nightColors = [
      Colors.indigo.shade900,
      Colors.blueGrey.shade800,
      Colors.black,
    ];

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

    /// >>> Sun or Moon (Soft, warm)
    final sunColor = Color(0xFFFFD54F); // Sun-like yellow
    final moonColor = Colors.grey.shade300;

    final celestialPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          isDay ? sunColor : moonColor,
          (isDay ? sunColor : moonColor).withOpacity(0.3),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 0.25),
          radius: 50,
        ),
      );

    // Move sun/moon in an arc
    double angle = localValue * pi; // 0 to π
    double xPos = size.width / 2 + cos(angle - pi / 2) * size.width * 0.3;
    double yPos = size.height * 0.25 + sin(angle - pi / 2) * size.height * 0.15;

    canvas.drawCircle(Offset(xPos, yPos), 40, celestialPaint);

    /// >>> Water Ripple Effect (Subtle, professional)
    final ripplePaint = Paint()
      ..color = Colors.white.withOpacity(isDay ? 0.1 : 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final radius = 40 + localValue * 80 + i * 40;
      canvas.drawCircle(
        Offset(size.width / 2, size.height * 0.8),
        radius % (size.width / 2),
        ripplePaint,
      );
    }

    /// >>> Optional: Light shimmer over water for grocery-friendly feel
    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.1), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.2));

    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.2),
      shimmerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant WaterTwilightPainter oldDelegate) => true;
}*/


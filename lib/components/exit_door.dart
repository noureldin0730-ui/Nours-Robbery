import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';

class ExitDoor extends PositionComponent {
  double t = 0;

  ExitDoor(Vector2 pos)
      : super(position: pos, size: Vector2.all(LevelsData.tile)) {
    priority = 2;
  }

  @override
  void update(double dt) {
    t += dt;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x;

    // glow
    final glow = Paint()
      ..color = const Color(0xFF2ECC71)
          .withOpacity(0.4 + 0.2 * math.sin(t * 3))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawCircle(Offset(r / 2, r / 2), r * 0.7, glow);

    // door body
    final door = Paint()..color = const Color(0xFF2ECC71);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(6, 6, r - 12, r - 12),
        const Radius.circular(6),
      ),
      door,
    );

    // inner
    final inner = Paint()..color = const Color(0xFF1E8A4D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(14, 14, r - 28, r - 28),
        const Radius.circular(3),
      ),
      inner,
    );

    // arrow down
    final arrow = Paint()..color = const Color(0xFFB0FFD0);
    final path = Path()
      ..moveTo(r / 2 - 5, r / 2 - 3)
      ..lineTo(r / 2 + 5, r / 2 - 3)
      ..lineTo(r / 2, r / 2 + 5)
      ..close();
    canvas.drawPath(path, arrow);
  }
}
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';

class Gem extends PositionComponent {
  bool taken = false;
  double t = 0;

  Gem(Vector2 pos)
      : super(position: pos, size: Vector2.all(LevelsData.tile)) {
    priority = 1;
  }

  @override
  void update(double dt) {
    t += dt * 3;
  }

  @override
  void render(Canvas canvas) {
    if (taken) return;

    final cx = size.x / 2;
    final cy = size.y / 2 + math.sin(t) * 3;

    // glow
    final glow = Paint()
      ..color = const Color(0xFF4AD7FF)
          .withOpacity(0.3 + 0.15 * math.sin(t * 2))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset(cx, cy), 14, glow);

    // diamond
    final path = Path()
      ..moveTo(cx, cy - 12)
      ..lineTo(cx + 9, cy)
      ..lineTo(cx, cy + 12)
      ..lineTo(cx - 9, cy)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF4AD7FF));

    // inner highlight
    final inner = Path()
      ..moveTo(cx, cy - 6)
      ..lineTo(cx + 4, cy)
      ..lineTo(cx, cy + 6)
      ..lineTo(cx - 4, cy)
      ..close();
    canvas.drawPath(inner, Paint()..color = const Color(0xFFB0EEFF));
  }
}
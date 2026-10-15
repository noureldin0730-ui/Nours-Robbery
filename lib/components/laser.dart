import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';

class Laser extends PositionComponent {
  final Vector2 from;
  final Vector2 to;
  double t = 0;

  Laser(this.from, this.to) : super(size: Vector2.zero()) {
    priority = 4;
  }

  @override
  void update(double dt) {
    t += dt;
  }

  /// بتشيك إذا الليزر بيلمس البطل
  bool hits(Vector2 playerPos) {
    final p = playerPos + Vector2(LevelsData.tile / 2, LevelsData.tile / 2);
    final ab = to - from;
    final ap = p - from;
    final abLenSq = ab.length2;
    if (abLenSq == 0) return false;
    final u = (ap.dot(ab) / abLenSq).clamp(0.0, 1.0);
    final closest = from + ab * u;
    return (p - closest).length < LevelsData.tile * 0.35;
  }

  @override
  void render(Canvas canvas) {
    final pulse = 0.7 + 0.3 * math.sin(t * 8);

    // glow
    final glow = Paint()
      ..color = const Color(0xFFFF3B3B).withOpacity(0.35 * pulse)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawLine(
      Offset(from.x, from.y),
      Offset(to.x, to.y),
      glow,
    );

    // core
    final paint = Paint()
      ..color = const Color(0xFFFF3B3B).withOpacity(pulse)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(from.x, from.y),
      Offset(to.x, to.y),
      paint,
    );
  }
}
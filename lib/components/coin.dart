import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';

class Coin extends PositionComponent {
  bool taken = false;
  double t = 0;

  Coin(Vector2 pos)
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
      ..color = const Color(0xFFFFD54A)
          .withOpacity(0.25 + 0.15 * math.sin(t * 2))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(Offset(cx, cy), 10, glow);

    // outer
    final outer = Paint()..color = const Color(0xFFFFD54A);
    canvas.drawCircle(Offset(cx, cy), 9, outer);

    // inner
    final inner = Paint()..color = const Color(0xFFB8860B);
    canvas.drawCircle(Offset(cx, cy), 5, inner);

    // shine
    final shine = Paint()..color = const Color(0xFFFFF3B0);
    canvas.drawCircle(Offset(cx - 3, cy - 3), 2, shine);
  }
}
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';

class Decor extends PositionComponent {
  final StagePalette palette;

  Decor({
    required Vector2 pos,
    required double size,
    required this.palette,
  }) : super(position: pos, size: Vector2.all(size)) {
    priority = -20;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x;
    final cx = (position.x / r).floor();
    final cy = (position.y / r).floor();
    final even = (cx + cy) % 2 == 0;

    // checkerboard base
    final paint = Paint()..color = even ? palette.floorA : palette.floorB;
    canvas.drawRect(Rect.fromLTWH(0, 0, r, r), paint);

    // subtle grid
    final gridPaint = Paint()
      ..color = const Color(0x11000000)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, r - 1), Offset(r, r - 1), gridPaint);
    canvas.drawLine(Offset(r - 1, 0), Offset(r - 1, r), gridPaint);

    // accent dot for texture
    if ((cx * 7 + cy * 13) % 11 == 0) {
      final dot = Paint()..color = palette.accent.withOpacity(0.15);
      canvas.drawCircle(Offset(r / 2, r / 2), 3, dot);
    }
  }
}
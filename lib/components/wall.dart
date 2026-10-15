import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Wall extends PositionComponent {
  final Color color;
  final Color topColor;

  Wall({
    required Vector2 pos,
    required double size,
    required this.color,
    required this.topColor,
  }) : super(position: pos, size: Vector2.all(size)) {
    priority = -10;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x;

    // body
    final body = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(0, 0, r, r), body);

    // top highlight
    final top = Paint()..color = topColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, r, 6), top);

    // darker bottom edge
    final bottom = Paint()..color = Colors.black.withOpacity(0.3);
    canvas.drawRect(Rect.fromLTWH(0, r - 4, r, 4), bottom);

    // grid line
    final line = Paint()
      ..color = const Color(0xFF1A1A26)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(1, 1, r - 2, r - 2), line);
  }
}
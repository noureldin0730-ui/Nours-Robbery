import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';
import 'wall.dart';

class Player extends PositionComponent {
  final List<Wall> walls;

  String facing = 'down';
  double anim = 0;
  String _queuedDir = '';

  Player({required Vector2 position, required this.walls})
      : super(position: position, size: Vector2.all(LevelsData.tile)) {
    priority = 5;
  }

  /// بتنادى من onDragEnd — البطل بيتحرك خطوة
  void moveStep(String dir) {
    _queuedDir = dir;
    facing = dir;
    anim += 1;
  }

  @override
  void update(double dt) {
    anim += dt * 4;
    if (_queuedDir.isEmpty) return;

    const step = LevelsData.tile;
    final from = position.clone();
    final to = from.clone();

    switch (_queuedDir) {
      case 'up':    to.y -= step; break;
      case 'down':  to.y += step; break;
      case 'left':  to.x -= step; break;
      case 'right': to.x += step; break;
    }
    _queuedDir = '';

    // collision: نشوف هل المربع الجديد فيه حيطة
    final targetCenter = to + Vector2(LevelsData.tile / 2, LevelsData.tile / 2);
    for (final w in walls) {
      if (w.position.x <= targetCenter.x &&
          targetCenter.x < w.position.x + w.size.x &&
          w.position.y <= targetCenter.y &&
          targetCenter.y < w.position.y + w.size.y) {
        return;
      }
    }
    position = to;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x;
    final cx = r / 2;
    final cy = r / 2;

    // shadow
    final shadow = Paint()..color = const Color(0x66000000);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, r - 6), width: r * 0.6, height: 8),
      shadow,
    );

    // body (hoodie)
    final body = Paint()..color = const Color(0xFF4A90E2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 12, cy - 6, 24, 24),
        const Radius.circular(6),
      ),
      body,
    );

    // stripe
    final stripe = Paint()..color = const Color(0xFF2A5A99);
    canvas.drawRect(Rect.fromLTWH(cx - 12, cy + 4, 24, 4), stripe);

    // head
    final skin = Paint()..color = const Color(0xFFF4C896);
    canvas.drawCircle(Offset(cx, cy - 14), 9, skin);

    // mask (bandit)
    final mask = Paint()..color = const Color(0xFF1A1A26);
    canvas.drawRect(Rect.fromLTWH(cx - 9, cy - 16, 18, 7), mask);

    // eyes
    final eye = Paint()..color = Colors.white;
    final pupil = Paint()..color = Colors.black;
    double off = 0;
    if (facing == 'left') off = -1;
    if (facing == 'right') off = 1;
    canvas.drawCircle(Offset(cx - 4 + off, cy - 12), 1.8, eye);
    canvas.drawCircle(Offset(cx + 4 + off, cy - 12), 1.8, eye);
    canvas.drawCircle(Offset(cx - 4 + off * 1.5, cy - 12), 0.9, pupil);
    canvas.drawCircle(Offset(cx + 4 + off * 1.5, cy - 12), 0.9, pupil);

    // legs
    final leg = Paint()..color = const Color(0xFF2A2A3A);
    final swing = math.sin(anim) * 3;
    canvas.drawRect(Rect.fromLTWH(cx - 9, cy + 16 + swing, 6, 6), leg);
    canvas.drawRect(Rect.fromLTWH(cx + 3, cy + 16 - swing, 6, 6), leg);
  }
}
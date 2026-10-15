import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';
import 'wall.dart';

class Guard extends PositionComponent {
  final List<Vector2> path;
  final double speed;

  int pathIdx = 1;
  String facing = 'right';
  double anim = 0;
  double visionRange = LevelsData.tile * 5;
  double visionHalfAngle = math.pi / 4; // 90° cone total

  Guard({
    required Vector2 position,
    required this.path,
    required this.speed,
  }) : super(position: position, size: Vector2.all(LevelsData.tile)) {
    priority = 3;
  }

  Vector2 get facingVec {
    switch (facing) {
      case 'up':    return Vector2(0, -1);
      case 'down':  return Vector2(0, 1);
      case 'left':  return Vector2(-1, 0);
      default:      return Vector2(1, 0);
    }
  }

  @override
  void update(double dt) {
    if (path.isEmpty) return;

    final target = path[pathIdx % path.length];
    final diff = target - position;
    final dist = diff.length;

    if (dist < 2) {
      pathIdx = (pathIdx + 1) % path.length;
      return;
    }

    final dir = diff / dist;
    position += dir * speed * 60 * dt;

    if (dir.x.abs() > dir.y.abs()) {
      facing = dir.x > 0 ? 'right' : 'left';
    } else {
      facing = dir.y > 0 ? 'down' : 'up';
    }

    anim += dt * 6;
  }

  /// بتشيك هل الحارس شايف البطل — بناءً على:
  /// 1. المسافة أقل من visionRange
  /// 2. الزاوية أقل من visionHalfAngle
  /// 3. مفيش حيطة بينهم
  bool canSee(Vector2 playerPos, List<Wall> walls) {
    final origin = position + Vector2(LevelsData.tile / 2, LevelsData.tile / 2);
    final target = playerPos + Vector2(LevelsData.tile / 2, LevelsData.tile / 2);
    final toPlayer = target - origin;
    final dist = toPlayer.length;

    if (dist > visionRange) return false;
    if (dist == 0) return true;

    // الزاوية
    final angle = math.acos(
      (toPlayer.normalized().dot(facingVec)).clamp(-1.0, 1.0),
    );
    if (angle > visionHalfAngle) return false;

    // raycast — نشوف لو فيه حيطة في الطريق
    final steps = (dist / 8).ceil();
    for (int i = 1; i < steps; i++) {
      final p = origin + toPlayer * (i / steps);
      for (final w in walls) {
        if (w.position.x <= p.x &&
            p.x < w.position.x + w.size.x &&
            w.position.y <= p.y &&
            p.y < w.position.y + w.size.y) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  void render(Canvas canvas) {
    final r = size.x;
    final cx = r / 2;
    final cy = r / 2;

    // vision cone
    final origin = Offset(cx, cy);
    final facingV = facingVec;
    final baseAngle = math.atan2(facingV.y, facingV.x);

    final cone = Path()
      ..moveTo(origin.dx, origin.dy)
      ..arcTo(
        Rect.fromCircle(center: origin, radius: visionRange),
        baseAngle - visionHalfAngle,
        visionHalfAngle * 2,
        false,
      )
      ..close();

    final conePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF5050).withOpacity(0.35),
          const Color(0xFFFF5050).withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: origin, radius: visionRange));
    canvas.drawPath(cone, conePaint);

    // shadow
    final shadow = Paint()..color = const Color(0x66000000);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, r - 6), width: r * 0.6, height: 8),
      shadow,
    );

    // body (red uniform)
    final body = Paint()..color = const Color(0xFFE24A4A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 12, cy - 6, 24, 24),
        const Radius.circular(6),
      ),
      body,
    );
    final stripe = Paint()..color = const Color(0xFF8A1E1E);
    canvas.drawRect(Rect.fromLTWH(cx - 12, cy + 4, 24, 4), stripe);

    // head
    final skin = Paint()..color = const Color(0xFFE8B888);
    canvas.drawCircle(Offset(cx, cy - 14), 9, skin);

    // cap
    final cap = Paint()..color = const Color(0xFF1A1A26);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy - 16), radius: 10),
      math.pi,
      math.pi,
      true,
      cap,
    );

    // eyes
    final eye = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(cx - 3, cy - 12), 1.6, eye);
    canvas.drawCircle(Offset(cx + 3, cy - 12), 1.6, eye);

    // legs
    final leg = Paint()..color = const Color(0xFF2A2A3A);
    final swing = math.sin(anim) * 3;
    canvas.drawRect(Rect.fromLTWH(cx - 9, cy + 16 + swing, 6, 6), leg);
    canvas.drawRect(Rect.fromLTWH(cx + 3, cy + 16 - swing, 6, 6), leg);
  }
}
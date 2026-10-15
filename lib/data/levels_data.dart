import 'package:flutter/material.dart';

class LevelsData {
  static const double tile = 48.0;

  static final List<StageDef> stages = [
    stage1(),
    stage2(),
    stage3(),
    stage4(),
    stage5(),
    stage6(),
  ];

  // ============================================================
  // STAGE 1 — The Small House
  // ============================================================
  static StageDef stage1() => StageDef(
        name: 'The Small House',
        time: 90,
        palette: const StagePalette(
          floorA: Color(0xFF2A2A3A),
          floorB: Color(0xFF232334),
          wall: Color(0xFF5E5E78),
          wallTop: Color(0xFF7A7A96),
          accent: Color(0xFFFFD54A),
        ),
        map: const [
          '####################',
          '#..................#',
          '#..C...........C...#',
          '#....########......#',
          '#....#......#......#',
          '#....#..G...#..C...#',
          '#....#......#......#',
          '#....#......#......#',
          '#....########......#',
          '#..................#',
          '#..................#',
          '#..................#',
          '#..C............C..#',
          '#..................#',
          '#..................#',
          '####################',
        ],
        playerStart: const GridPoint(3, 10),
        exitPos: const GridPoint(10, 14),
        coins: const [
          GridPoint(3, 2),
          GridPoint(15, 2),
          GridPoint(16, 5),
          GridPoint(3, 12),
          GridPoint(16, 12),
        ],
        gems: const [GridPoint(7, 5)],
        guards: const [
          GuardDef(
            start: GridPoint(9, 11),
            speed: 1.2,
            path: [
              GridPoint(9, 11),
              GridPoint(9, 13),
              GridPoint(13, 13),
              GridPoint(13, 11),
            ],
          ),
        ],
        lasers: const [],
      );

  // ============================================================
  // STAGE 2 — The Villa
  // ============================================================
  static StageDef stage2() => StageDef(
        name: 'The Villa',
        time: 120,
        palette: const StagePalette(
          floorA: Color(0xFF3A2A2A),
          floorB: Color(0xFF2E1F1F),
          wall: Color(0xFF8A5A3A),
          wallTop: Color(0xFFAA7A5A),
          accent: Color(0xFFFFAA33),
        ),
        map: const [
          '##########################',
          '#........................#',
          '#..C....C.......C....C...#',
          '#..####################..#',
          '#..#..................#..#',
          '#..#..G....C..........#..#',
          '#..#..........####....#..#',
          '#..#..........#..#....#..#',
          '#..#..........#..#....#..#',
          '#..#....C.....#..#....#..#',
          '#..############..#....#..#',
          '#................#....#..#',
          '#................#....#..#',
          '#................######..#',
          '#....................C...#',
          '#........................#',
          '#........................#',
          '#..C...........C.......C.#',
          '#........................#',
          '##########################',
        ],
        playerStart: const GridPoint(3, 13),
        exitPos: const GridPoint(12, 18),
        coins: const [
          GridPoint(3, 2),
          GridPoint(8, 2),
          GridPoint(16, 2),
          GridPoint(21, 2),
          GridPoint(11, 5),
          GridPoint(14, 9),
          GridPoint(21, 14),
          GridPoint(3, 17),
          GridPoint(15, 17),
          GridPoint(23, 17),
        ],
        gems: const [GridPoint(7, 5)],
        guards: const [
          GuardDef(
            start: GridPoint(5, 15),
            speed: 1.4,
            path: [GridPoint(5, 15), GridPoint(20, 15)],
          ),
          GuardDef(
            start: GridPoint(20, 3),
            speed: 1.0,
            path: [GridPoint(20, 3), GridPoint(20, 17)],
          ),
        ],
        lasers: const [
          LaserDef(from: GridPoint(13, 11), to: GridPoint(13, 12)),
        ],
      );

  // ============================================================
  // STAGE 3 — The Bank
  // ============================================================
  static StageDef stage3() => StageDef(
        name: 'The Bank',
        time: 140,
        palette: const StagePalette(
          floorA: Color(0xFF1E2A3A),
          floorB: Color(0xFF16202C),
          wall: Color(0xFF3A5A7A),
          wallTop: Color(0xFF5A7A9A),
          accent: Color(0xFF4AD7FF),
        ),
        map: const [
          '############################',
          '#..........................#',
          '#..####.####.####.####....#',
          '#..#....................#..#',
          '#..#..C..C..C..C..C....#..#',
          '#..#....................#..#',
          '#..####..####..####..####..#',
          '#..........................#',
          '#..C..C..C..C..C..C..C..C..#',
          '#..........................#',
          '#..####..####..####..####..#',
          '#..#....................#..#',
          '#..#..G..G..G..G..G....#..#',
          '#..#....................#..#',
          '#..####..####..####..####..#',
          '#..........................#',
          '#..C..C..C..C..C..C..C..C..#',
          '#..........................#',
          '#..........................#',
          '############################',
        ],
        playerStart: const GridPoint(2, 17),
        exitPos: const GridPoint(25, 17),
        coins: const [
          GridPoint(4, 4), GridPoint(7, 4), GridPoint(10, 4), GridPoint(13, 4), GridPoint(16, 4),
          GridPoint(3, 8), GridPoint(6, 8), GridPoint(9, 8), GridPoint(12, 8), GridPoint(15, 8), GridPoint(18, 8), GridPoint(21, 8),
          GridPoint(3, 16), GridPoint(6, 16), GridPoint(9, 16), GridPoint(12, 16), GridPoint(15, 16), GridPoint(18, 16), GridPoint(21, 16),
        ],
        gems: const [
          GridPoint(5, 12), GridPoint(8, 12), GridPoint(11, 12), GridPoint(14, 12), GridPoint(17, 12),
        ],
        guards: const [
          GuardDef(start: GridPoint(5, 7), speed: 1.6,
              path: [GridPoint(5, 7), GridPoint(22, 7)]),
          GuardDef(start: GridPoint(22, 10), speed: 1.4,
              path: [GridPoint(22, 10), GridPoint(5, 10)]),
          GuardDef(start: GridPoint(14, 13), speed: 1.8,
              path: [GridPoint(14, 13), GridPoint(14, 17), GridPoint(2, 17)]),
        ],
        lasers: const [
          LaserDef(from: GridPoint(2, 9), to: GridPoint(25, 9)),
          LaserDef(from: GridPoint(2, 15), to: GridPoint(25, 15)),
        ],
      );

  // ============================================================
  // STAGE 4 — The Museum
  // ============================================================
  static StageDef stage4() => StageDef(
        name: 'The Museum',
        time: 160,
        palette: const StagePalette(
          floorA: Color(0xFF2A1E3A),
          floorB: Color(0xFF1F1530),
          wall: Color(0xFF6A4A9A),
          wallTop: Color(0xFF8A6ABA),
          accent: Color(0xFFC77AFF),
        ),
        map: const [
          '##############################',
          '#............................#',
          '#..####..####..####..####....#',
          '#..#......................#..#',
          '#..#..G..G..G..G..G..G....#..#',
          '#..#......................#..#',
          '#..####..####..####..####....#',
          '#............................#',
          '#..C..C..C..C..C..C..C..C..C..#',
          '#............................#',
          '#..####..####..####..####....#',
          '#..#......................#..#',
          '#..#..G..G..G..G..G..G....#..#',
          '#..#......................#..#',
          '#..####..####..####..####....#',
          '#............................#',
          '#..C..C..C..C..C..C..C..C..C..#',
          '#............................#',
          '#............................#',
          '##############################',
        ],
        playerStart: const GridPoint(2, 18),
        exitPos: const GridPoint(27, 18),
        coins: const [
          GridPoint(3, 8), GridPoint(6, 8), GridPoint(9, 8), GridPoint(12, 8),
          GridPoint(15, 8), GridPoint(18, 8), GridPoint(21, 8), GridPoint(24, 8),
          GridPoint(3, 16), GridPoint(6, 16), GridPoint(9, 16), GridPoint(12, 16),
          GridPoint(15, 16), GridPoint(18, 16), GridPoint(21, 16), GridPoint(24, 16),
        ],
        gems: const [
          GridPoint(4, 4), GridPoint(7, 4), GridPoint(10, 4),
          GridPoint(13, 4), GridPoint(16, 4), GridPoint(19, 4),
          GridPoint(4, 12), GridPoint(7, 12), GridPoint(10, 12),
          GridPoint(13, 12), GridPoint(16, 12), GridPoint(19, 12),
        ],
        guards: const [
          GuardDef(start: GridPoint(6, 7), speed: 2.0,
              path: [GridPoint(6, 7), GridPoint(24, 7)]),
          GuardDef(start: GridPoint(24, 11), speed: 1.8,
              path: [GridPoint(24, 11), GridPoint(6, 11)]),
          GuardDef(start: GridPoint(6, 15), speed: 2.2,
              path: [GridPoint(6, 15), GridPoint(24, 15)]),
        ],
        lasers: const [
          LaserDef(from: GridPoint(2, 6), to: GridPoint(27, 6)),
          LaserDef(from: GridPoint(2, 10), to: GridPoint(27, 10)),
          LaserDef(from: GridPoint(2, 14), to: GridPoint(27, 14)),
        ],
      );

  // ============================================================
  // STAGE 5 — The Casino
  // ============================================================
  static StageDef stage5() => StageDef(
        name: 'The Casino',
        time: 180,
        palette: const StagePalette(
          floorA: Color(0xFF3A2A1A),
          floorB: Color(0xFF2A1E10),
          wall: Color(0xFF9A6A2A),
          wallTop: Color(0xFFBA8A4A),
          accent: Color(0xFFFFD54A),
        ),
        map: const [
          '################################',
          '#..............................#',
          '#..C..C..C..C..C..C..C..C..C..#',
          '#..............................#',
          '#..####..####..####..####....#..#',
          '#..#......................#..#..#',
          '#..#..G..G..G..G..G..G....#..#..#',
          '#..#......................#..#..#',
          '#..####..####..####..####....#..#',
          '#..............................#',
          '#..C..C..C..C..C..C..C..C..C..#',
          '#..............................#',
          '#..####..####..####..####....#..#',
          '#..#......................#..#..#',
          '#..#..G..G..G..G..G..G....#..#..#',
          '#..#......................#..#..#',
          '#..####..####..####..####....#..#',
          '#..............................#',
          '#..C..C..C..C..C..C..C..C..C..#',
          '#..............................#',
          '################################',
        ],
        playerStart: const GridPoint(2, 18),
        exitPos: const GridPoint(29, 18),
        coins: const [
          GridPoint(3, 2), GridPoint(6, 2), GridPoint(9, 2), GridPoint(12, 2),
          GridPoint(15, 2), GridPoint(18, 2), GridPoint(21, 2), GridPoint(24, 2), GridPoint(27, 2),
          GridPoint(3, 10), GridPoint(6, 10), GridPoint(9, 10), GridPoint(12, 10),
          GridPoint(15, 10), GridPoint(18, 10), GridPoint(21, 10), GridPoint(24, 10), GridPoint(27, 10),
          GridPoint(3, 18), GridPoint(6, 18), GridPoint(9, 18), GridPoint(12, 18),
          GridPoint(15, 18), GridPoint(18, 18), GridPoint(21, 18), GridPoint(24, 18), GridPoint(27, 18),
        ],
        gems: const [
          GridPoint(4, 6), GridPoint(7, 6), GridPoint(10, 6), GridPoint(13, 6),
          GridPoint(16, 6), GridPoint(19, 6), GridPoint(22, 6),
          GridPoint(4, 14), GridPoint(7, 14), GridPoint(10, 14), GridPoint(13, 14),
          GridPoint(16, 14), GridPoint(19, 14), GridPoint(22, 14),
        ],
        guards: const [
          GuardDef(start: GridPoint(6, 4), speed: 2.2,
              path: [GridPoint(6, 4), GridPoint(26, 4)]),
          GuardDef(start: GridPoint(26, 8), speed: 2.0,
              path: [GridPoint(26, 8), GridPoint(6, 8)]),
          GuardDef(start: GridPoint(6, 12), speed: 2.4,
              path: [GridPoint(6, 12), GridPoint(26, 12)]),
          GuardDef(start: GridPoint(26, 16), speed: 2.0,
              path: [GridPoint(26, 16), GridPoint(6, 16)]),
        ],
        lasers: const [
          LaserDef(from: GridPoint(2, 7), to: GridPoint(29, 7)),
          LaserDef(from: GridPoint(2, 11), to: GridPoint(29, 11)),
          LaserDef(from: GridPoint(2, 15), to: GridPoint(29, 15)),
        ],
      );

  // ============================================================
  // STAGE 6 — The Vault
  // ============================================================
  static StageDef stage6() => StageDef(
        name: 'The Vault',
        time: 200,
        palette: const StagePalette(
          floorA: Color(0xFF1A1A2A),
          floorB: Color(0xFF101018),
          wall: Color(0xFF4A4A6A),
          wallTop: Color(0xFF6A6A8A),
          accent: Color(0xFF4AD7FF),
        ),
        map: const [
          '##################################',
          '#................................#',
          '#..########..########..########..#',
          '#..#......#..#......#..#......#..#',
          '#..#..G...#..#..G...#..#..G...#..#',
          '#..#......#..#......#..#......#..#',
          '#..########..########..########..#',
          '#................................#',
          '#..C..C..C..C..C..C..C..C..C..C..#',
          '#................................#',
          '#..########..########..########..#',
          '#..#......#..#......#..#......#..#',
          '#..#..G...#..#..G...#..#..G...#..#',
          '#..#......#..#......#..#......#..#',
          '#..########..########..########..#',
          '#................................#',
          '#..C..C..C..C..C..C..C..C..C..C..#',
          '#................................#',
          '#..C..C..C..C..C..C..C..C..C..C..#',
          '#................................#',
          '#................................#',
          '##################################',
        ],
        playerStart: const GridPoint(2, 20),
        exitPos: const GridPoint(32, 20),
        coins: const [
          GridPoint(3, 8), GridPoint(6, 8), GridPoint(9, 8), GridPoint(12, 8),
          GridPoint(15, 8), GridPoint(18, 8), GridPoint(21, 8), GridPoint(24, 8),
          GridPoint(27, 8), GridPoint(30, 8),
          GridPoint(3, 16), GridPoint(6, 16), GridPoint(9, 16), GridPoint(12, 16),
          GridPoint(15, 16), GridPoint(18, 16), GridPoint(21, 16), GridPoint(24, 16),
          GridPoint(27, 16), GridPoint(30, 16),
          GridPoint(3, 18), GridPoint(6, 18), GridPoint(9, 18), GridPoint(12, 18),
          GridPoint(15, 18), GridPoint(18, 18), GridPoint(21, 18), GridPoint(24, 18),
          GridPoint(27, 18), GridPoint(30, 18),
        ],
        gems: const [
          GridPoint(4, 4), GridPoint(14, 4), GridPoint(24, 4),
          GridPoint(4, 12), GridPoint(14, 12), GridPoint(24, 12),
        ],
        guards: const [
          GuardDef(start: GridPoint(5, 7), speed: 2.4,
              path: [GridPoint(5, 7), GridPoint(29, 7)]),
          GuardDef(start: GridPoint(29, 9), speed: 2.2,
              path: [GridPoint(29, 9), GridPoint(5, 9)]),
          GuardDef(start: GridPoint(5, 15), speed: 2.6,
              path: [GridPoint(5, 15), GridPoint(29, 15)]),
          GuardDef(start: GridPoint(29, 17), speed: 2.4,
              path: [GridPoint(29, 17), GridPoint(5, 17)]),
        ],
        lasers: const [
          LaserDef(from: GridPoint(2, 10), to: GridPoint(33, 10)),
          LaserDef(from: GridPoint(2, 14), to: GridPoint(33, 14)),
        ],
      );
}

// ============================================================
// DATA CLASSES — بتعرّف شكل البيانات
// ============================================================

class StageDef {
  final String name;
  final double time;
  final StagePalette palette;
  final List<String> map;
  final GridPoint playerStart;
  final GridPoint exitPos;
  final List<GridPoint> coins;
  final List<GridPoint> gems;
  final List<GuardDef> guards;
  final List<LaserDef> lasers;

  const StageDef({
    required this.name,
    required this.time,
    required this.palette,
    required this.map,
    required this.playerStart,
    required this.exitPos,
    required this.coins,
    required this.gems,
    required this.guards,
    required this.lasers,
  });
}

class StagePalette {
  final Color floorA;
  final Color floorB;
  final Color wall;
  final Color wallTop;
  final Color accent;

  const StagePalette({
    required this.floorA,
    required this.floorB,
    required this.wall,
    required this.wallTop,
    required this.accent,
  });
}

class GridPoint {
  final int x;
  final int y;
  const GridPoint(this.x, this.y);
}

class GuardDef {
  final GridPoint start;
  final double speed;
  final List<GridPoint> path;

  const GuardDef({
    required this.start,
    required this.speed,
    required this.path,
  });
}

class LaserDef {
  final GridPoint from;
  final GridPoint to;
  const LaserDef({required this.from, required this.to});
}
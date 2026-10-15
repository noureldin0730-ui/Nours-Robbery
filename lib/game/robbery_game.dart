import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../data/levels_data.dart';
import '../data/game_state.dart';
import '../components/wall.dart';
import '../components/decor.dart';
import '../components/coin.dart';
import '../components/gem.dart';
import '../components/exit_door.dart';
import '../components/player.dart';
import '../components/guard.dart';
import '../components/laser.dart';

enum GameStatus { playing, won, lost, timeUp }

class RobberyGame extends FlameGame with DragCallbacks {
  final int stageIndex;
  final void Function(GameStatus status) onStatusChange;
  final void Function(int timeLeft) onTimeUpdate;

  late StageDef _def;
  late Player player;
  final List<Guard> guards = [];
  final List<Coin> coins = [];
  final List<Gem> gems = [];
  final List<Laser> lasers = [];
  final List<Wall> walls = [];

  double _timeLeft = 0;
  GameStatus _status = GameStatus.playing;
  bool _finished = false;
  double _hudTimer = 0;

  final GameState _state = GameState();

  RobberyGame({
    required this.stageIndex,
    required this.onStatusChange,
    required this.onTimeUpdate,
  });

  @override
  Color backgroundColor() => const Color(0xFF0A0A14);

  @override
  Future<void> onLoad() async {
    _def = LevelsData.stages[stageIndex];
    _timeLeft = _def.time;
    _state.resetStageScore();
    _buildWorld();
  }

  void _buildWorld() {
    final map = _def.map;
    final palette = _def.palette;

    // build walls & floor
    for (int y = 0; y < map.length; y++) {
      final row = map[y];
      for (int x = 0; x < row.length; x++) {
        final c = row[x];
        final pos = Vector2(x * LevelsData.tile, y * LevelsData.tile);

        if (c == '#') {
          final w = Wall(
            pos: pos,
            size: LevelsData.tile,
            color: palette.wall,
            topColor: palette.wallTop,
          );
          walls.add(w);
          add(w);
        } else {
          add(Decor(pos: pos, size: LevelsData.tile, palette: palette));
        }
      }
    }

    // coins
    for (final p in _def.coins) {
      final c = Coin(Vector2(p.x * LevelsData.tile, p.y * LevelsData.tile));
      coins.add(c);
      add(c);
    }

    // gems
    for (final p in _def.gems) {
      final g = Gem(Vector2(p.x * LevelsData.tile, p.y * LevelsData.tile));
      gems.add(g);
      add(g);
    }

    // guards
    for (final def in _def.guards) {
      final g = Guard(
        position: Vector2(
          def.start.x * LevelsData.tile,
          def.start.y * LevelsData.tile,
        ),
        path: def.path
            .map((p) => Vector2(p.x * LevelsData.tile, p.y * LevelsData.tile))
            .toList(),
        speed: def.speed,
      );
      guards.add(g);
      add(g);
    }

    // lasers
    for (final l in _def.lasers) {
      final laser = Laser(
        Vector2(l.from.x * LevelsData.tile, l.from.y * LevelsData.tile),
        Vector2(l.to.x * LevelsData.tile, l.to.y * LevelsData.tile),
      );
      lasers.add(laser);
      add(laser);
    }

    // exit door
    final e = _def.exitPos;
    add(ExitDoor(Vector2(e.x * LevelsData.tile, e.y * LevelsData.tile)));

    // player
    final s = _def.playerStart;
    player = Player(
      position: Vector2(s.x * LevelsData.tile, s.y * LevelsData.tile),
      walls: walls,
    );
    add(player);

    // camera follow
    camera.follow(player);
    camera.viewfinder.anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_status != GameStatus.playing) return;

    _timeLeft -= dt;
    _hudTimer += dt;

    if (_hudTimer >= 0.2) {
      _hudTimer = 0;
      onTimeUpdate(_timeLeft.ceil());
    }

    if (_timeLeft <= 0) {
      _finish(GameStatus.timeUp);
      return;
    }

    // coin pickup
    for (final c in coins) {
      if (!c.taken &&
          c.position.distanceTo(player.position) < LevelsData.tile * 0.6) {
        c.taken = true;
        c.removeFromParent();
        _state.addCoin();
      }
    }

    // gem pickup
    for (final g in gems) {
      if (!g.taken &&
          g.position.distanceTo(player.position) < LevelsData.tile * 0.6) {
        g.taken = true;
        g.removeFromParent();
        _state.addGem();
      }
    }

    // guard detection
    for (final g in guards) {
      if (g.canSee(player.position, walls)) {
        _finish(GameStatus.lost);
        return;
      }
    }

    // laser detection
    for (final l in lasers) {
      if (l.hits(player.position)) {
        _finish(GameStatus.lost);
        return;
      }
    }

    // exit reach (only when everything collected)
    final remaining = coins.where((c) => !c.taken).length +
        gems.where((g) => !g.taken).length;

    if (remaining == 0) {
      final e = _def.exitPos;
      final exitVec = Vector2(e.x * LevelsData.tile, e.y * LevelsData.tile);
      if (exitVec.distanceTo(player.position) < LevelsData.tile * 0.7) {
        _finish(GameStatus.won);
      }
    }
  }

  void _finish(GameStatus status) {
    if (_finished) return;
    _finished = true;
    _status = status;

    if (status == GameStatus.won) {
      _state.commitStage();
    }
    onStatusChange(status);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_status != GameStatus.playing) return;
    final v = event.velocity;
    if (v.length < 60) return;

    if (v.x.abs() > v.y.abs()) {
      player.moveStep(v.x > 0 ? 'right' : 'left');
    } else {
      player.moveStep(v.y > 0 ? 'down' : 'up');
    }
  }
}
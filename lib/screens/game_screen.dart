import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../data/game_state.dart';
import '../game/robbery_game.dart';
import 'lose_screen.dart';
import 'win_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameState _state = GameState();
  late RobberyGame _game;

  int _timeLeft = 0;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _buildGame();
  }

  void _buildGame() {
    _navigated = false;
    _timeLeft = 0;
    _game = RobberyGame(
      stageIndex: _state.currentStage.value,
      onStatusChange: _onStatusChange,
      onTimeUpdate: (t) {
        if (mounted) setState(() => _timeLeft = t);
      },
    );
  }

  void _onStatusChange(GameStatus status) {
    if (_navigated) return;
    _navigated = true;

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      switch (status) {
        case GameStatus.won:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const WinScreen()),
          );
          break;
        case GameStatus.lost:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const LoseScreen(reason: 'A guard spotted you'),
            ),
          );
          break;
        case GameStatus.timeUp:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const LoseScreen(reason: 'Time ran out'),
            ),
          );
          break;
        case GameStatus.playing:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _game),

          // HUD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _hudChip(
                    '💰',
                    '${_state.totalScore.value + _state.stageScore}',
                    const Color(0xFFFFD54A),
                  ),
                  _hudChip(
                    '🎯',
                    '${_state.currentStage.value + 1}/6',
                    const Color(0xFF7AD7FF),
                  ),
                  _hudChip(
                    '⏱',
                    '$_timeLeft',
                    _timeLeft <= 15
                        ? const Color(0xFFFF5050)
                        : const Color(0xFFB0FFD0),
                  ),
                ],
              ),
            ),
          ),

          // back button
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      border: Border.all(
                        color: const Color(0xFF555566),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'EXIT',
                      style: TextStyle(
                        color: Color(0xFFAAAABB),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hudChip(String icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 15)),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
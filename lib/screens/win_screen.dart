import 'package:flutter/material.dart';

import '../data/game_state.dart';
import '../data/save_manager.dart';
import '../data/levels_data.dart';
import 'game_screen.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen>
    with SingleTickerProviderStateMixin {
  final GameState _state = GameState();
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    _ctrl.forward();
    _save();
  }

  Future<void> _save() async {
    await SaveManager.saveProgress(
      highestStage: _state.highestStage.value,
      totalScore: _state.totalScore.value,
    );
  }

  bool get _isFinalStage =>
      _state.currentStage.value + 1 >= LevelsData.stages.length;

  void _nextStage() {
    if (_isFinalStage) {
      _state.resetAll();
      SaveManager.clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const _FinalScreen()),
        (route) => false,
      );
      return;
    }

    _state.nextStage();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
  }

  void _menu() {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A2A14),
              Color(0xFF0A0A14),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '🏆',
                      style: TextStyle(fontSize: 60),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'ESCAPED!',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2ECC71),
                        letterSpacing: 6,
                        shadows: [
                          Shadow(
                            color: Color(0xFF1E8A4D),
                            offset: Offset(3, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Stage ${_state.currentStage.value + 1} cleared',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFB0FFD0),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        border: Border.all(
                          color: const Color(0xFF2ECC71).withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _statRow('Coins collected', '${_state.stageCoins}'),
                          const SizedBox(height: 6),
                          _statRow('Gems collected', '${_state.stageGems}'),
                          const Divider(color: Color(0xFF2ECC71), height: 20),
                          _statRow('Stage score', '${_state.stageScore}',
                              highlight: true),
                          const SizedBox(height: 6),
                          _statRow('Total score', '${_state.totalScore.value}',
                              highlight: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // buttons
                    if (!_isFinalStage)
                      _btn(
                        'NEXT STAGE ▶',
                        const Color(0xFF2ECC71),
                        _nextStage,
                      ),
                    const SizedBox(height: 10),
                    _btn(
                      'MENU',
                      const Color(0xFF7AD7FF),
                      _menu,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFAAAABB),
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 30),
        Text(
          value,
          style: TextStyle(
            color: highlight
                ? const Color(0xFFFFD54A)
                : const Color(0xFFB0FFD0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _btn(String label, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 240,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// شاشة النهاية — لما تخلص كل المراحل
class _FinalScreen extends StatelessWidget {
  const _FinalScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A1A0A),
              Color(0xFF0A0A14),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('👑', style: TextStyle(fontSize: 70)),
                const SizedBox(height: 12),
                const Text(
                  'MASTER THIEF',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFD54A),
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: Color(0xFFB8860B),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'All stages cleared',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFFE08A),
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'A GAME BY NOUR ELDIN',
                  style: TextStyle(
                    color: Color(0xFF555566),
                    fontSize: 11,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (route) => false);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 240,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        border: Border.all(
                            color: const Color(0xFFFFD54A), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'PLAY AGAIN ↺',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFD54A),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
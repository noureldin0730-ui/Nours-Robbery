import 'package:flutter/material.dart';

import '../data/game_state.dart';
import 'game_screen.dart';

class LoseScreen extends StatefulWidget {
  final String reason;
  const LoseScreen({super.key, required this.reason});

  @override
  State<LoseScreen> createState() => _LoseScreenState();
}

class _LoseScreenState extends State<LoseScreen>
    with SingleTickerProviderStateMixin {
  final GameState _state = GameState();
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 12, end: -12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12, end: 6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 6, end: -6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6, end: 0), weight: 1),
    ]).animate(_ctrl);

    _ctrl.forward();
  }

  void _retry() {
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
              Color(0xFF2A0A0A),
              Color(0xFF0A0A14),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: AnimatedBuilder(
                animation: _shakeAnim,
                builder: (_, child) => Transform.translate(
                  offset: Offset(_shakeAnim.value, 0),
                  child: child,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🚨', style: TextStyle(fontSize: 60)),
                    const SizedBox(height: 12),
                    const Text(
                      'BUSTED!',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFE24A4A),
                        letterSpacing: 6,
                        shadows: [
                          Shadow(
                            color: Color(0xFF8A1E1E),
                            offset: Offset(3, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.reason,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFFAAAA),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        border: Border.all(
                          color: const Color(0xFFE24A4A).withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _statRow('Stage', '${_state.currentStage.value + 1}/6'),
                          const SizedBox(height: 6),
                          _statRow('Coins collected', '${_state.stageCoins}'),
                          const SizedBox(height: 6),
                          _statRow('Gems collected', '${_state.stageGems}'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // buttons
                    _btn('TRY AGAIN ↺', const Color(0xFFFFD54A), _retry),
                    const SizedBox(height: 10),
                    _btn('MENU', const Color(0xFF7AD7FF), _menu),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
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
          style: const TextStyle(
            color: Color(0xFFFFAAAA),
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
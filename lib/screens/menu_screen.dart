import 'package:flutter/material.dart';

import '../data/game_state.dart';
import '../data/save_manager.dart';
import 'game_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  final GameState _state = GameState();
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  int _highestStage = 0;
  int _totalScore = 0;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final h = await SaveManager.loadHighestStage();
    final s = await SaveManager.loadTotalScore();
    if (!mounted) return;
    setState(() {
      _highestStage = h;
      _totalScore = s;
      _state.highestStage.value = h;
      _state.totalScore.value = s;
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _startGame({bool fromStart = true}) {
    final stage = fromStart ? 0 : _highestStage.clamp(0, 5);
    _state.currentStage.value = stage;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
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
              Color(0xFF0A0A14),
              Color(0xFF161628),
              Color(0xFF0A0A14),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // decorative coins
              ..._buildFloatingCoins(),

              // main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // title
                    AnimatedBuilder(
                      animation: _pulseAnim,
                      builder: (_, __) {
                        return Column(
                          children: [
                            Text(
                              "NOUR'S",
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFFFD54A),
                                letterSpacing: 8,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFFFFD54A)
                                        .withOpacity(_pulseAnim.value * 0.8),
                                    blurRadius: 24,
                                  ),
                                  const Shadow(
                                    color: Color(0xFFB8860B),
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "ROBBERY",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF4AD7FF),
                                letterSpacing: 12,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFF1E8AA8),
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "— THE BOSS THIEF —",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF7AD7FF),
                        letterSpacing: 4,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // buttons
                    _menuButton(
                      label: _highestStage > 0 ? "CONTINUE" : "START",
                      icon: _highestStage > 0 ? Icons.play_arrow_rounded : Icons.play_arrow_rounded,
                      color: const Color(0xFFFFD54A),
                      onTap: () => _startGame(fromStart: _highestStage == 0),
                    ),

                    const SizedBox(height: 12),

                    if (_highestStage > 0)
                      _menuButton(
                        label: "NEW GAME",
                        icon: Icons.refresh_rounded,
                        color: const Color(0xFF4AD7FF),
                        onTap: () => _startGame(fromStart: true),
                      ),

                    const SizedBox(height: 28),

                    // stats
                    if (_totalScore > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          border: Border.all(
                            color: const Color(0xFFFFD54A).withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('💰',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Text(
                              '$_totalScore',
                              style: const TextStyle(
                                color: Color(0xFFFFD54A),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text('🎯',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Text(
                              '${_highestStage + 1}/6',
                              style: const TextStyle(
                                color: Color(0xFF7AD7FF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // bottom credit
              const Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Text(
                  'A GAME BY NOUR ELDIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF555566),
                    fontSize: 10,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 260,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingCoins() {
    final rng = [
      [0.08, 0.15, '💰', 22, 0.5],
      [0.88, 0.20, '💎', 26, 0.7],
      [0.12, 0.75, '💰', 20, 0.6],
      [0.85, 0.80, '💎', 24, 0.8],
      [0.50, 0.10, '💰', 18, 0.4],
      [0.50, 0.88, '💎', 20, 0.5],
    ];
    return rng.map((e) {
      return Positioned(
        left: (e[0] as double) * MediaQuery.of(context).size.width,
        top: (e[1] as double) * MediaQuery.of(context).size.height,
        child: Opacity(
          opacity: e[4] as double,
          child: Text(
            e[2] as String,
            style: TextStyle(fontSize: (e[3] as int).toDouble()),
          ),
        ),
      );
    }).toList();
  }
}
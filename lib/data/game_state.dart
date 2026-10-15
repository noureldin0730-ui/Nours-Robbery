import 'package:flutter/foundation.dart';

/// الحالة العامة للعبة — بتتنقل بين الشاشات
class GameState {
  static final GameState _instance = GameState._();
  factory GameState() => _instance;
  GameState._();

  /// المرحلة الحالية (0 = الأولى)
  final ValueNotifier<int> currentStage = ValueNotifier<int>(0);

  /// مجموع النقاط من كل المراحل
  final ValueNotifier<int> totalScore = ValueNotifier<int>(0);

  /// أعلى مرحلة وصلها اللاعب
  final ValueNotifier<int> highestStage = ValueNotifier<int>(0);

  /// نقاط المرحلة الحالية (مش بتتحفظ إلا لما تخلص)
  int stageScore = 0;
  int stageCoins = 0;
  int stageGems = 0;

  /// نبدأ مرحلة جديدة — نصفّر عدادات المرحلة
  void resetStageScore() {
    stageScore = 0;
    stageCoins = 0;
    stageGems = 0;
  }

  /// نجمع عملة
  void addCoin() {
    stageScore += 10;
    stageCoins += 1;
  }

  /// نجمع جوهرة
  void addGem() {
    stageScore += 50;
    stageGems += 1;
  }

  /// خلّصنا المرحلة — نحفظ النقاط
  void commitStage() {
    totalScore.value += stageScore;
    if (currentStage.value + 1 > highestStage.value) {
      highestStage.value = currentStage.value + 1;
    }
  }

  /// نروح للمرحلة اللي بعدها
  void nextStage() {
    currentStage.value += 1;
    resetStageScore();
  }

  /// إعادة تعيين شاملة
  void resetAll() {
    currentStage.value = 0;
    totalScore.value = 0;
    highestStage.value = 0;
    resetStageScore();
  }
}
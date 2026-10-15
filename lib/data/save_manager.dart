import 'package:shared_preferences/shared_preferences.dart';

/// بيحفظ تقدم اللاعب — عشان لما يقفل اللعبة ويرجع، يلاقي حاله
class SaveManager {
  static const String _keyHighestStage = 'highest_stage';
  static const String _keyTotalScore   = 'total_score';

  /// نجيب أعلى مرحلة وصلها
  static Future<int> loadHighestStage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyHighestStage) ?? 0;
  }

  /// نجيب مجموع النقاط
  static Future<int> loadTotalScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalScore) ?? 0;
  }

  /// نحفظ التقدم
  static Future<void> saveProgress({
    required int highestStage,
    required int totalScore,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyHighestStage, highestStage);
    await prefs.setInt(_keyTotalScore, totalScore);
  }

  /// نمسح كل حاجة (لما اللاعب يبدأ من الأول)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHighestStage);
    await prefs.remove(_keyTotalScore);
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  const PreferencesManager._();

  static const PreferencesManager instance = PreferencesManager._();

  static const String _keyuserName = 'username';
  static const String _keydarkMode = 'darkmode';
  static const String _keyIsFirstRun = 'is_first_run';

  Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyuserName, userName);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyuserName);
  }

  Future<void> setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keydarkMode, darkMode);
  }

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keydarkMode) ?? false;
  }

  Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool(_keyIsFirstRun) ?? true;
     if (isFirst) {
      await prefs.setBool(_keyIsFirstRun, false);
    }
    return isFirst;   
 }
  Future<void> resetPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

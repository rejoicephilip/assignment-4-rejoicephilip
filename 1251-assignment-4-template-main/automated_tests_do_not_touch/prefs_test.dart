import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assignment_04/managers/preferences_manager.dart';

void main() {
  late PreferencesManager prefsManager;

  setUp(() async {
    prefsManager = PreferencesManager.instance;
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
  });

  group('Preferences Storage', () {
    test('Username can be saved and retrieved', () async {
      const testName = 'Test User';

      await prefsManager.setUserName(testName);

      final retrievedName = await prefsManager.getUserName();

      expect(retrievedName, testName);
    });

    test('First run detection works correctly', () async {
      var isFirstRun = await prefsManager.isFirstRun();
      expect(isFirstRun, true);

      await prefsManager.setUserName('New User');

      isFirstRun = await prefsManager.isFirstRun();
      expect(isFirstRun, false);
    });

    test('Dark mode preference can be saved and retrieved', () async {
      var darkMode = await prefsManager.getDarkMode();
      expect(darkMode, false);

      await prefsManager.setDarkMode(true);

      darkMode = await prefsManager.getDarkMode();
      expect(darkMode, true);

      await prefsManager.setDarkMode(false);

      darkMode = await prefsManager.getDarkMode();
      expect(darkMode, false);
    });

    test('Multiple preferences persist correctly', () async {
      await prefsManager.setUserName('Test User');
      await prefsManager.setDarkMode(true);

      final username = await prefsManager.getUserName();
      final darkMode = await prefsManager.getDarkMode();

      expect(username, 'Test User');
      expect(darkMode, true);
    });
  });
}

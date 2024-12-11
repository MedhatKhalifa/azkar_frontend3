import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferencesWithCache? _prefs;

  /// Initializes the SharedPreferencesWithCache instance
  static Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: null, // Allow all keys by default
      ),
    );
  }

  /// Access the instance
  static SharedPreferencesWithCache get instance {
    if (_prefs == null) {
      throw StateError(
          'SharedPrefs.init() must be called before using SharedPrefs.');
    }
    return _prefs!;
  }
}

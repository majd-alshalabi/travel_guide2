import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_guide/core/utils/themes.dart';

class ThemeCacheHelper {
  Future<void> cacheThemeIndex(int themeIndex) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("THEME_INDEX", themeIndex);
  }

  Future<int> getCachedThemeIndex() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedThemeIndex = sharedPreferences.getInt("THEME_INDEX");
    if (cachedThemeIndex != null) {
      return cachedThemeIndex;
    } else {
      return 0;
    }
  }

  Future<ThemeType> getSelectedThemeType() async {
    int selectedValue = await getCachedThemeIndex();
    if (selectedValue == 1) {
      return ThemeType.settAlKolDark;
    } else {
      return ThemeType.settAlKolLight; // set your default value here
    }
  }
}

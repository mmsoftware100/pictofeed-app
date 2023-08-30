
import 'package:Okuna/models/theme.dart';
import 'package:Okuna/services/storage.dart';
import 'package:Okuna/services/utils_service.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class ThemeService {
  late UtilsService _utilsService;

  Stream<OBTheme> get themeChange => _themeChangeSubject.stream;
  final _themeChangeSubject = ReplaySubject<OBTheme>(maxSize: 1);

  Random random = new Random();

  late OBTheme _activeTheme;

  OBStorage? _storage;

  List<OBTheme> _themes = [
    OBTheme(
        id: 1,
        name: 'Light Cinnabar',
        primaryAccentColor: '#A71D31, #F53844',
        primaryTextColor: '#505050',
        secondaryTextColor: '#676767',
        primaryColor: '#ffffff',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview:
            'assets/images/theme-previews/theme-preview-light-cinnabar.png'),
    OBTheme(
        id: 2,
        name: 'Space Cinnabar',
        primaryTextColor: '#ffffff',
        secondaryTextColor: '#b3b3b3',
        primaryColor: '#232323',
        primaryAccentColor: '#A71D31, #F53844',
        successColor: '#7ED321',
        successColorAccent: '#ffffff',
        dangerColor: '#FF3860',
        dangerColorAccent: '#ffffff',
        themePreview:
            'assets/images/theme-previews/theme-preview-space-cinnabar.png')
  ];

  ThemeService() {
    _setActiveTheme(_themes[0]);
  }

  void setStorageService(StorageService storageService) {
    _storage = storageService.getSystemPreferencesStorage(namespace: 'theme');
    this._bootstrap();
  }

  void setUtilsService(UtilsService utilsService) {
    _utilsService = utilsService;
  }

  void setActiveTheme(OBTheme theme) {
    _setActiveTheme(theme);
    _storeActiveThemeId(theme.id!);
  }

  void _bootstrap() async {
    int? activeThemeId = await _getStoredActiveThemeId();
    if (activeThemeId != null) {
      OBTheme activeTheme = await _getThemeWithId(activeThemeId);
      _setActiveTheme(activeTheme);
    }
  }

  void _setActiveTheme(OBTheme theme) {
    _activeTheme = theme;
    _themeChangeSubject.add(theme);
  }

  void _storeActiveThemeId(int themeId) {
    if (_storage != null) _storage!.set('activeThemeId', themeId.toString());
  }

  Future<OBTheme> _getThemeWithId(int id) async {
    return _themes.firstWhere((OBTheme theme) {
      return theme.id == id;
    });
  }

  Future<int?> _getStoredActiveThemeId() async {
    int? activeThemeId = (await _storage!.get('activeThemeId')) as int?;
    return activeThemeId;
  }

  OBTheme getActiveTheme() {
    return _activeTheme;
  }

  bool isActiveTheme(OBTheme theme) {
    return theme.id == this.getActiveTheme().id;
  }

  List<OBTheme> getCuratedThemes() {
    return _themes.toList();
  }

  String generateRandomHexColor() {
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while (length-- > 0) hex += chars[(random.nextInt(16)) | 0];
    return hex;
  }
}

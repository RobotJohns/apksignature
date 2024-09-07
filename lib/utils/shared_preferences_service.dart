import 'package:shared_preferences/shared_preferences.dart';

const String apkSignInfo = 'ApkSignInfo';

class SharedPreferencesService {
  late SharedPreferences sharedPreferences;
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  factory SharedPreferencesService() {
    return _instance;
  }
  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  SharedPreferencesService._internal() {
    // 初始化
    _init();
  }
  _init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getData(String key) async {
    return sharedPreferences.getString(key);
  }
}

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SessionManagement {
  static const String APP_KEY = "MocaPASS";
  static const String IS_LOGIN_KEY = "login_key";
  static const String TOKEN_KEY = "token_key";
  static const String cameraFacingKey = "cameraFacingKey";

  static late Box<dynamic> box;

  static Future<Box> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    box = await Hive.openBox(APP_KEY);
    return box;
  }

  static Future<void> signOut() async {
    await box.clear();
  }

  static bool isLoggedIn() => box.get(IS_LOGIN_KEY, defaultValue: false);

  static String? getUserToken() => box.get(TOKEN_KEY) ?? "";

  static void createSession({required String token}) {
    box.put(TOKEN_KEY, token);
    box.put(IS_LOGIN_KEY, true);
  }

  static void setCamFacing(int facing) async {
    await box.put(cameraFacingKey, facing);
  }

  static void setStringValue(String key, String value) async {
    await box.put(key, value);
  }
  static String getValue(String key) => box.get(key) ?? "";

  static int getCamFacing(String key) => box.get(key) ?? 0;
}

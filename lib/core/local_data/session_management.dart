import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SessionManagement {
  static const int pageNumber = 1;
  static const int pageSize = 500;
  static var minCost = 0.0;
  static var maxCost = 3200.0;
  static const String APP_KEY = "catering_app";
  static const String EMAIL_KEY = "email_key";
  static const String NAME_KEY = "name_key";
  static const String IMAGE_URL_KEY = "image_url_key";
  static const String PHONE_KEY = "phone_key";
  static const String ROLE_KEY = "role_key";
  static const String ON_Boarding_KEY = "on_boarding_key";
  static const String IS_LOGIN_KEY = "login_key";
  static const String TOKEN_KEY = "token_key";
  static const String GIDTOKEN_KEY = "g_id_token_key";
  static const String NOTIFICATIONS_TOKEN_KEY = "notifications_key";
  static const String IMAGE_FILE_KEY = "image_key";
  static const String LANG_KEY = "lang_key";
  static const String DEVICE_TOKEN_SENT_KEY = "token_sent_key";
  static const String COUNTRY_ID_KEY = "country_id_key";
  static const String CART_ITEMS_KEY = "cart_items_key";
  static const String REMOTE_CONFIG_IOS_UPLOADING = "ios_isUploading";

  static late Box<dynamic> box;


  //this is called only once in main
  static Future<Box> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    box = await Hive.openBox(APP_KEY);
    return box;
  }

  static Future<void> signOut() async {
    final lang = box.get(LANG_KEY);
    await box.clear();
    await box.put(LANG_KEY, lang);
  }


  static void removeAllCart() {
    box.put(CART_ITEMS_KEY, 0);
  }

  static bool isLoggedIn() => box.get(IS_LOGIN_KEY, defaultValue: false);

  static bool isOnBoarding() => box.get(ON_Boarding_KEY, defaultValue: false);

  static bool iosIsUploading() =>
      box.get(REMOTE_CONFIG_IOS_UPLOADING, defaultValue: false);

  static String getLanguage() => box.get(LANG_KEY);

  static String? getUserToken() => box.get(TOKEN_KEY) ?? "";
  static String? getUserRole() => box.get(ROLE_KEY) ?? "";
  static String? getNotificationToken() => box.get(NOTIFICATIONS_TOKEN_KEY) ?? "";
  static String? getGoogleIdToken() => box.get(GIDTOKEN_KEY) ?? "";

  static int getCountryId() => box.get(COUNTRY_ID_KEY);

  static bool isDeviceTokenSent() => box.get(DEVICE_TOKEN_SENT_KEY) ?? false;

  static bool isEnglish() => getLanguage() == "en";

  static void setOnBoarding() {
    box.put(ON_Boarding_KEY, true);
  }

  static void createSession(
      {
      // required String email,
      // required String name,
      // required String phone,
      required String token, required String role}) {
    // box.put(EMAIL_KEY, email);
    // box.put(NAME_KEY, name);
    box.put(TOKEN_KEY, token);
    // box.put(PHONE_KEY, phone);
    box.put(IS_LOGIN_KEY, true);
    box.put(ROLE_KEY, role);
  }

  static void setLanguage(String lang) {
    box.put(LANG_KEY, lang);
  }

  static void setRemoteConfigIOSUploading(bool isUploading) {
    box.put(REMOTE_CONFIG_IOS_UPLOADING, isUploading);
  }

  static void saveUserName(String userName) {
    box.put(NAME_KEY, userName);
  }

  static void saveUserImage(String image) {
    box.put(IMAGE_URL_KEY, image);
  }

  // static void saveCountryId(CountryModel countryModel) {
  //   box.put(COUNTRY_ID_KEY, countryModel.id);
  // }

  static void savePhone(String phone) {
    box.put(PHONE_KEY, phone);
  }

  static void saveSentDeviceToken() {
    box.put(DEVICE_TOKEN_SENT_KEY, true);
  }
  static void notificationToken(String token) {
    box.put(NOTIFICATIONS_TOKEN_KEY, token);
  }
  static void googleIdToken(String token) {
    box.put(GIDTOKEN_KEY, token);
  }

  static String getImagePath() => box.get(IMAGE_FILE_KEY);

  /*static Future<void> signOut() async {
    final lang = sharedPreferences.getString(LANG_KEY);
    await sharedPreferences.clear();
    await sharedPreferences.setString(LANG_KEY, lang);
  }*/

  static String getValue(String key) => box.get(key) ?? "";
}

abstract class Endpoints {
  /////////////////////////////
  static String get login => "Account/authenticate";

  static String get scanIn => "mobile/AllMobileBookings/ScanIn/";

  static String get scanOut => "mobile/AllMobileBookings/ScanOut/";

  static String get refreshToken => 'Account/RefreshToken';
}

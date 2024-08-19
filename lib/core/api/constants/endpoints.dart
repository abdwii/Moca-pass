abstract class Endpoints {
  /////////////////////////////
  static String get login => "Account/authenticate";

  static String get scanIn => "AllMobileBookings/ScanIn/";

  static String get scanOut => "AllMobileBookings/ScanOut/";

  static String get refreshToken => 'Account/RefreshToken';

/*  @POST('Account/RefreshToken')
  Future<HeaderResponse<LoginResponse>> getNewToken(
      @Query('ExpiredToken') String token);*/
}

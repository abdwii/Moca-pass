abstract class APICallerConfiguration {
  static String get baseUrl => "https://alafein.azurewebsites.net/api/v1/";
  static const String baseLiveUrl = 'https://api.copolitan.com/api/';
  // static const String baseDebugUrl = 'https://testapi.techno-politan.xyz/api/';
  static const String baseDebugUrl =
      'https://moca-testapi-dev.azurewebsites.net/api/';
  static const String workSpaceLiveUrl =
      'https://moca-workspace-live.azurewebsites.net/api/';
  static const String workSpaceDevUrl =
      'https://moca-api-dev-ugqsn6ev6q-uc.a.run.app/api/';
  static const String workSpaceStageUrl =
      'https://workspace-reservation-api-staging-ugqsn6ev6q-uc.a.run.app/api/';
}

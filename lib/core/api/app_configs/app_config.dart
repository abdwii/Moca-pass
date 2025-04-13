import 'config_dev.dart';
import 'config_live.dart';
import 'config_stage.dart';

enum Environment { development, staging, production }

class AppConfig {
  static Environment environment = Environment.development;

  static String get baseUrl {
    switch (environment) {
      case Environment.development:
        return DevConfig.baseUrl;
      case Environment.staging:
        return StageConfig.baseUrl;
      case Environment.production:
        return LiveConfig.baseUrl;
    }
  }

  static String get authBaseUrl {
    switch (environment) {
      case Environment.development:
        return DevConfig.authBaseUrl;
      case Environment.staging:
        return StageConfig.authBaseUrl;
      case Environment.production:
        return LiveConfig.authBaseUrl;
    }
  }
}

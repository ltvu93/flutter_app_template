enum Environment {
  dev,
  prod,
}

class AppConfig {
  final String apiBaseUrl;

  AppConfig._({this.apiBaseUrl});

  factory AppConfig._dev() {
    return AppConfig._(
      apiBaseUrl: 'https://example.com/dev',
    );
  }

  factory AppConfig._prod() {
    return AppConfig._(
      apiBaseUrl: 'https://example.com/prod',
    );
  }

  static build(Environment environment) {
    switch (environment) {
      case Environment.prod:
        instance = AppConfig._prod();
        break;
      case Environment.dev:
      default:
        instance = AppConfig._dev();
        break;
    }
  }

  static AppConfig instance;
}

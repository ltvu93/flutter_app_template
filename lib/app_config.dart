enum Environment {
  dev,
  prod,
}

class AppConfig {
  final String apiBaseUrl;

  AppConfig._({required this.apiBaseUrl});

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

  static void build(Environment environment) {
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

  static late AppConfig instance;
}

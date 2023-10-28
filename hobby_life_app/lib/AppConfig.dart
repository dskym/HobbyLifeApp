enum Flavor { DEV, PRODUCTION }

class AppConfig {
  String appName = "";
  String baseUrl = "";
  Flavor flavor = Flavor.DEV;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    baseUrl = "",
    Flavor flavor = Flavor.DEV,
  }) {
    return shared = AppConfig(
      appName,
      baseUrl,
      flavor,
    );
  }

  AppConfig(this.appName, this.baseUrl, this.flavor);
}
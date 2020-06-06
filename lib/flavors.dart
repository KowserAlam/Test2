enum Flavor {
  PROD,
  DEV,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'Job Express';
      case Flavor.DEV:
        return 'Job Express Dev';
      default:
        return 'title';
    }
  }

}

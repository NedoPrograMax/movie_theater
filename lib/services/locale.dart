class Locale {
  Locale._();
  static final Locale _shared = Locale._();
  factory Locale.instance() => _shared;

  String? locale;

  void setLocale(String value) {
    locale = value;
  }
}

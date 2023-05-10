import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final SharedPreferences sharedPrefferenes;
  LocalRepository({required this.sharedPrefferenes});

  static const _isLight = "isLight";
  static const _accesToken = "accesToken";
  static const _favoriteModels = "favoriteMovies";
  final streamController = StreamController<List<int>>.broadcast();

  String? get accessToken => sharedPrefferenes.getString(_accesToken);

  set accessToken(String? value) {
    if (value != null) {
      sharedPrefferenes.setString(_accesToken, value);
    }
  }

  bool get isLight => sharedPrefferenes.getBool(_isLight) ?? false;

  set isLight(bool? value) {
    if (value != null) {
      sharedPrefferenes.setBool(_isLight, value);
    }
  }

  void addFavorite(int movieId) {
    final list = _getFavorites();
    list.add(movieId.toString());
    sharedPrefferenes.setStringList(_favoriteModels, list);
    _updateStream();
  }

  void removeFavorite(int movieId) {
    final list = _getFavorites();
    list.remove(movieId.toString());
    sharedPrefferenes.setStringList(_favoriteModels, list);
    _updateStream();
  }

  List<int> _getFavoritesInt() =>
      _getFavorites().map((e) => int.parse(e)).toList();

  List<String> _getFavorites() =>
      sharedPrefferenes.getStringList(_favoriteModels) ?? [];

  void _updateStream() => streamController.sink.add(_getFavoritesInt());

  bool isFavorite(int movieId) {
    final list = _getFavoritesInt();
    return list.any((element) => element == movieId);
  }

  Stream<List<int>> getFavoritesStream() {
    Future.delayed(
      const Duration(milliseconds: 100),
    ).then((value) => _updateStream());

    return streamController.stream;
  }
}

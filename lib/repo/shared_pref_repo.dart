import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shit_grabber/utils/list_extensions.dart';

class SharedPrefRepo {
  Stream<SharedPreferences> init() =>
      SharedPreferences.getInstance().asStream();

  Stream<void> reload() {
    return init().flatMap((_sharedPreferences) =>
        Stream.fromFuture(_sharedPreferences.reload()).map((_) => true));
  }

  Stream<String?> getString(String key) =>
      init().map((_sharedPreferences) => _sharedPreferences.getString(key));

  Stream<bool> setString(String key, String value) =>
      init().flatMap((_sharedPreferences) =>
          _sharedPreferences.setString(key, value).asStream());

  Stream<List<String>> getStringList(String key) =>
      init().map((_sharedPreferences) =>
          _sharedPreferences.getStringList(key) ??
          List<String>.empty(growable: true));

  Stream<bool> setStringList(String key, List<String> list) =>
      init().flatMap((_sharedPreferences) =>
          _sharedPreferences.setStringList(key, list).asStream());

  //TODO : add sorting by latest
  Stream<bool> addStringsToList(String key, List<String> newValues) =>
      getStringList(key).flatMap((list) {
        list.addAllUniqueElements(newValues);
        return setStringList(key, list).map((result) => result);
      });

  Stream<bool?> getBool(String key) =>
      init().map((_sharedPreferences) => _sharedPreferences.getBool(key));

  Stream<bool> setBool(String key, bool value) =>
      init().flatMap((_sharedPreferences) =>
          _sharedPreferences.setBool(key, value).asStream());
}

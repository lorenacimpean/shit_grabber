import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shit_grabber/utils/list_extensions.dart';

class SharedPrefRepo {
  Stream<SharedPreferences> init() {
    return Stream.fromFuture(SharedPreferences.getInstance());
  }

  Stream<void> reload() {
    return init().flatMap((_sharedPreferences) {
      return Stream.fromFuture(_sharedPreferences.reload()).map((_) => true);
    });
  }

  Stream<String?> getString(String key) {
    return init().map((_sharedPreferences) {
      return _sharedPreferences.getString(key);
    });
  }

  Stream<bool> setString(String key, String value) {
    return init().flatMap((_sharedPreferences) {
      return _sharedPreferences.setString(key, value).asStream();
    });
  }

  Stream<List<String>> getStringList(String key) {
    return init().map((_sharedPreferences) {
      print('SharedPrefRepo : GETTING THE LIST FOR KEY $key ');
      return _sharedPreferences.getStringList(key) ??
          List<String>.empty(growable: true);
    });
  }

  Stream<bool> setStringList(String key, List<String> list) {
    return init().flatMap((_sharedPreferences) {
      print('SharedPrefRepo : SAVING THE FOLLOWING ITEMS WITH KEY $key : '
          '\n $list ');
      return _sharedPreferences.setStringList(key, list).asStream();
    });
  }

//TODO : add sorting by latest
  Stream<bool> addStringsToList(String key, List<String> newValues) {
    return getStringList(key).flatMap((list) {
      list.addAllUnique(newValues.toSet().toList());
      print('SharedPrefRepo: NEW LIST: $list');
      return setStringList(key, list).map((result) {
        print('SharedPrefRepo: SETTING NEW LIST IN SHARED PREF');
        return result;
      });
    });
  }
}

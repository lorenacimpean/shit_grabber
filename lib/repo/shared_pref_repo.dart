import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo {
  Stream<SharedPreferences> _initSharedPreferences() {
    return Stream.fromFuture(SharedPreferences.getInstance());
  }

  Stream<void> reload() {
    return _initSharedPreferences().flatMap((_sharedPreferences) {
      return Stream.fromFuture(_sharedPreferences.reload()).map((_) => true);
    });
  }

  Stream<bool> setString(String key, String value) {
    return _initSharedPreferences().flatMap((_sharedPreferences) {
      return _sharedPreferences.setString(key, value).asStream();
    });
  }

  Stream<String?> getString(String key) {
    return _initSharedPreferences().map((_sharedPreferences) {
      return _sharedPreferences.getString(key);
    });
  }

  Stream<bool> setStringList(String key, List<String> list) {
    return _initSharedPreferences().flatMap((_sharedPreferences) {
      print('SharedPrefRepo : SAVING THE FOLLOWING ITEMS WITH KEY $key : '
          '\n $list ');
      return _sharedPreferences.setStringList(key, list).asStream();
    });
  }

  Stream<List<String>?> getStringList(String key) {
    return _initSharedPreferences().map((_sharedPreferences) {
      print('SharedPrefRepo : GETTING THE LIST FOR KEY $key : ');
      return _sharedPreferences.getStringList(key);
    });
  }

  Stream<bool> deleteStringFromList(String key, String deletedString) {
    print(
        'SharedPrefRepo : DELETING STRING $deletedString FROM LIST WITH KEY $key');
    return getStringList(key).flatMap((list) {
      List<String> newList = [];
      list?.removeWhere((element) => element == deletedString);
      newList.addAll(list!.toList());
      print('SharedPrefRepo: NEW LIST: $newList');
      return setStringList(key, newList).map((result) {
        print('SharedPrefRepo: SETTING NEW LIST IN SHARED PREF');
        return result;
      });
    });
  }

  Stream<bool> addStringsToList(String key, List<String> newValues) {
    print(
        'SharedPrefRepo : DELETING STRING $newValues FROM LIST WITH KEY $key');
    return getStringList(key).flatMap((list) {
      List<String> newList = [];
      newList.addAll(newValues.toSet().toList());
      print('SharedPrefRepo: NEW LIST: $newList');
      return setStringList(key, newList).map((result) {
        print('SharedPrefRepo: SETTING NEW LIST IN SHARED PREF');
        return result;
      });
    });
  }
}

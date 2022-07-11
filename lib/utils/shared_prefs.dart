import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? "";
  String get status => _sharedPrefs.getString(keyStatus) ?? "";
  String get nameFirst => _sharedPrefs.getString(keyNameFirst) ?? "";
  String get namePrefix => _sharedPrefs.getString(keyNamePrefix) ?? "";
  String get nameLast => _sharedPrefs.getString(keyNameLast) ?? "";
  String get messageSender => _sharedPrefs.getString(keyMessageSender) ?? "";
  String get nameSuffix => _sharedPrefs.getString(keyNameSuffix) ?? "";
  String get remember => _sharedPrefs.getString(keyRemember) ?? "";

  int get userId => _sharedPrefs.getInt(keyUserId) ?? 0;
  int get clientId => _sharedPrefs.getInt(keyClientId) ?? 0;

  set username(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }

  set userId(int value) {
    _sharedPrefs.setInt(keyUserId, value);
  }

  set clientId(int value) {
    _sharedPrefs.setInt(keyClientId, value);
  }

  set status(String value) {
    _sharedPrefs.setString(keyStatus, value);
  }

  set nameFirst(String value) {
    _sharedPrefs.setString(keyNameFirst, value);
  }

  set namePrefix(String value) {
    _sharedPrefs.setString(keyNamePrefix, value);
  }

  set nameLast(String value) {
    _sharedPrefs.setString(keyNameLast, value);
  }

  set nameSuffix(String value) {
    _sharedPrefs.setString(keyNameSuffix, value);
  }

  set remember(String value) {
    _sharedPrefs.setString(keyRemember, value);
  }

  set messageSender(String value) {
    _sharedPrefs.setString(keyMessageSender, value);
  }
}

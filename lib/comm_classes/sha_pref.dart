import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:harcapp_core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class ShaPref{

  static late SharedPreferences _preferences;

  ShaPref();

  static Future<void> init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Map<String, dynamic> toMap(){
    final Map<String, dynamic> prefsMap = {};
    for(String key in _preferences.getKeys())
      prefsMap[key] = _preferences.get(key);
    return prefsMap;
  }

  static void setCustomMethods({
    required bool? Function(String key)? customGetBoolOrNull,
    required FutureOr<void> Function(String key, bool value)? customSetBool,

    required String? Function(String key)? customGetStringOrNull,
    required FutureOr<void> Function(String key, String value)? customSetString,

    required List<String>? Function(String key)? customGetStringListOrNull,
    required FutureOr<void> Function(String key, List<String> value)? customSetStringList,

    required String? Function(String key)? customGetMapJsonStrOrNull,
    required FutureOr<void> Function(String key, Map value)? customSetMap,

    required int? Function(String key)? customGetIntOrNull,
    required FutureOr<void> Function(String key, int value)? customSetInt,

    required double? Function(String key)? customGetDoubleOrNull,
    required FutureOr<void> Function(String key, double value)? customSetDouble,

    required String? Function(String key)? customGetDateTimeStrOrNull,
    required FutureOr<void> Function(String key, DateTime? value)? customSetDateTime,

    required bool Function(String key)? customExists,
    required FutureOr<void> Function(String key)? customRemove,
    required void Function()? customClear,

  }){
    ShaPref.customGetBoolOrNull = customGetBoolOrNull;
    ShaPref.customSetBool = customSetBool;

    ShaPref.customGetStringOrNull = customGetStringOrNull;
    ShaPref.customSetString = customSetString;

    ShaPref.customGetStringListOrNull = customGetStringListOrNull;
    ShaPref.customSetStringList = customSetStringList;

    ShaPref.customGetMapJsonStrOrNull = customGetMapJsonStrOrNull;
    ShaPref.customSetMap = customSetMap;

    ShaPref.customGetIntOrNull = customGetIntOrNull;
    ShaPref.customSetInt = customSetInt;

    ShaPref.customGetDoubleOrNull = customGetDoubleOrNull;
    ShaPref.customSetDouble = customSetDouble;

    ShaPref.customGetDateStrTimeOrNull = customGetDateTimeStrOrNull;
    ShaPref.customSetDateTime = customSetDateTime;

    ShaPref.customExists = customExists;
    ShaPref.customRemove = customRemove;
    ShaPref.customClear = customClear;
  }

  static void setCustomMethodsWithMap(Map shaPrefMap, {SendPort? sendPort}) => setCustomMethods(
      customGetBoolOrNull: (String key) => shaPrefMap[key],
      customSetBool: (String key, bool value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetStringOrNull: (String key) => shaPrefMap[key],
      customSetString: (String key, String value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetStringListOrNull: (String key) => (shaPrefMap[key] as List).cast<String>(),
      customSetStringList: (String key, List<String> value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetMapJsonStrOrNull: (String key) => shaPrefMap[key],
      customSetMap: (String key, Map value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetIntOrNull: (String key) => shaPrefMap[key],
      customSetInt: (String key, int value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetDoubleOrNull: (String key) => shaPrefMap[key],
      customSetDouble: (String key, double value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customGetDateTimeStrOrNull: (String key) => shaPrefMap[key],
      customSetDateTime: (String key, DateTime? value){
        shaPrefMap[key] = value;
        sendPort?.send(Tuple2(key, value));
      },
      customExists: (String key) => shaPrefMap.containsKey(key),
      customRemove: (String key){
        shaPrefMap.remove(key);
        sendPort?.send(Tuple2(key, null));
      },
      customClear: () => shaPrefMap.clear()
  );

  static String badTypeErrMess(String key, dynamic e) => 'Tried to read value from shaPref key $key as incorrect type: ${e.toString()}';

  static FutureOr<void> set(String key, dynamic value){
    if(value == null)
      remove(key);
    else if(value is bool)
      setBool(key, value);
    else if(value is String)
      setString(key, value);
    else if(value is List<String>)
      setStringList(key, value);
    else if(value is Map)
      setMap(key, value);
    else if(value is int)
      setInt(key, value);
    else if(value is double)
      setDouble(key, value);
    else if(value is DateTime)
      setDateTime(key, value);
  }

  static bool? Function(String key)? customGetBoolOrNull;
  static bool? getBoolOrNull(String key) {
    try {
      if(customGetBoolOrNull != null) return customGetBoolOrNull?.call(key);
      return _preferences.getBool(key);
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static bool getBool(String key, bool def) => getBoolOrNull(key)??def;

  static FutureOr<void> Function(String key, bool value)? customSetBool;
  static Future<void> setBool(String key, bool value) async {
    if(customSetBool != null) return await customSetBool!.call(key, value);
    _preferences.setBool(key, value);
  }


  static String? Function(String key)? customGetStringOrNull;
  static String? getStringOrNull(String key) {
    try {
      if(customGetStringOrNull != null) return customGetStringOrNull?.call(key);
      return _preferences.getString(key);
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static String getString(String key, String def) => getStringOrNull(key)??def;

  static FutureOr<void> Function(String key, String value)? customSetString;
  static Future<void> setString(String key, String value) async {
    if(customSetString != null) return await customSetString!.call(key, value);
    _preferences.setString(key, value);
  }


  static List<String>? Function(String key)? customGetStringListOrNull;
  static List<String>? getStringListOrNull(String key) {
    try {
      if(customGetStringListOrNull != null) return customGetStringListOrNull!.call(key);
      return _preferences.getStringList(key);
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static List<String> getStringList(String key, List<String> def) => getStringListOrNull(key)??def;

  static FutureOr<void> Function(String key, List<String> value)? customSetStringList;
  static Future<void> setStringList(String key, List<String> value) async {
    if(customSetStringList != null) return await customSetStringList!.call(key, value);
    _preferences.setStringList(key, value);
  }


  static String? Function(String key)? customGetMapJsonStrOrNull;
  static Map<T_KEY, T_VAL>? getMapOrNull<T_KEY, T_VAL>(String key){
    try {
      if(customGetMapJsonStrOrNull != null){
        String? result = customGetMapJsonStrOrNull!(key);
        if(result == null) return null;
        return jsonDecode(result)?.cast<T_KEY, T_VAL>();
      }

      String? code = _preferences.getString(key);
      if(code == null) return null;
      return (jsonDecode(code) as Map).cast<T_KEY, T_VAL>();
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static Map<T_KEY, T_VAL> getMap<T_KEY, T_VAL>(String key, Map<T_KEY, T_VAL> def) =>
      getMapOrNull(key)??def;

  static FutureOr<void>? Function(String key, Map value)? customSetMap;
  static Future<void> setMap(String key, Map value) async {
    if(customSetMap != null) return await customSetMap!.call(key, value);
    _preferences.setString(key, jsonEncode(value));
  }


  static int? Function(String key)? customGetIntOrNull;
  static int? getIntOrNull(String key) {
    try {
      if(customGetIntOrNull != null) return customGetIntOrNull!.call(key);
      return _preferences.getInt(key);
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static int getInt(String key, int def) => getIntOrNull(key)??def;

  static FutureOr<void> Function(String key, int value)? customSetInt;
  static Future<void> setInt(String key, int value) async {
    if(customSetInt != null) return await customSetInt!.call(key, value);
    _preferences.setInt(key, value);
  }

  static double? Function(String key)? customGetDoubleOrNull;
  static double? getDoubleOrNull(String key) {
    try {
      if(customGetDoubleOrNull != null) return customGetDoubleOrNull!.call(key);
      return _preferences.getDouble(key);
    } catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static double getDouble(String key, double def) => getDoubleOrNull(key)??def;

  static FutureOr<void> Function(String key, double value)? customSetDouble;
  static Future<void> setDouble(String key, double value) async {
    if(customSetDouble != null) return await customSetDouble!.call(key, value);
    _preferences.setDouble(key, value);
  }


  static String? Function(String key)? customGetDateStrTimeOrNull;
  static DateTime? getDateTimeOrNull(String key){
    try {
      if(customGetDateStrTimeOrNull != null) return DateTime.tryParse(customGetDateStrTimeOrNull!(key)??'');
      String? dateTimeStr = getString(key, 'nic');
      if(dateTimeStr == 'nic') return null;
      return DateTime.tryParse(dateTimeStr);
    } on Exception catch (e){
      logger?.w(badTypeErrMess(key, e));
      remove(key);
      return null;
    }
  }

  static DateTime? getDateTime(String key, DateTime? def) => getDateTimeOrNull(key)??def;

  static FutureOr<void> Function(String key, DateTime? value)? customSetDateTime;
  static Future<void> setDateTime(String key, DateTime? value) async {
    if(customSetDateTime != null) return await customSetDateTime!(key, value);
    if(value == null) await remove(key);
    else await setString(key, value.toIso8601String());
  }


  static bool Function(String key)? customExists;
  static bool exists(String key) =>
      customExists?.call(key)??_preferences.get(key) != null;


  static FutureOr<void> Function(String key)? customRemove;
  static Future<void> remove(String key) async =>
      await (customRemove?.call(key)??_preferences.remove(key));

  static void Function()? customClear;
  static void clear(){
    if(customClear != null) return customClear!();
    _preferences.clear();
  }


}
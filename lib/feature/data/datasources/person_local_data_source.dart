import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_rick_and_morty/core/error/excaption.dart';

import 'package:the_rick_and_morty/feature/data/models/person_model.dart';

abstract class PersonLocalDataSource {
  /// Gets the cache [List<PersonModel>] which was gotten the last time
  /// the user had on internet connection.
  ///
  /// Throws [CacheExcaption] if no cached data is present.

  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personToCache(List<PersonModel> persons);
}

// ignore: constant_identifier_names
const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheExcaptions();
    }
  }

  @override
  Future<void> personToCache(List<PersonModel> persons) {
    List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    // ignore: avoid_print
    print('Persons to write Cache: ${jsonPersonsList.length}');
    // ignore: void_checks
    return Future.value(jsonPersonsList);
  }
}

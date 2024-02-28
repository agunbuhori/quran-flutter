import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<T>> loadListDataFromJson<T>(
    String jsonPath, T Function(Map<String, dynamic>) fromJson) async {
  // Load JSON data from the assets folder
  String jsonString = await rootBundle.loadString(jsonPath);

  // Parse the JSON string into a list of objects
  List<dynamic> jsonList = json.decode(jsonString);
  List<T> dataList = jsonList.map((json) => fromJson(json)).toList();

  return dataList;
}

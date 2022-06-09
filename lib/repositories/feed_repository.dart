import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PhotosRepository extends ChangeNotifier {
  List<String> photos = [];
  List<DateTime> datas = [
    DateTime.now(),
    DateTime.now().subtract(const Duration(minutes: 3)),
    DateTime.now().subtract(const Duration(minutes: 12)),
    DateTime.now().subtract(const Duration(minutes: 43)),
    DateTime.now().subtract(const Duration(hours: 1, minutes: 23)),
    DateTime.now().subtract(const Duration(hours: 6, minutes: 23)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 1, hours: 6, minutes: 23)),
    DateTime.now().subtract(const Duration(days: 2, hours: 8, minutes: 23)),
    DateTime.now().subtract(const Duration(days: 2, hours: 8, minutes: 23)),
  ];

  PhotosRepository();

  Future<List<String>> getAll() async {
    final url = Uri.parse('https://picsum.photos/v2/list?limit=10');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final photosList = jsonDecode(response.body) as List;

      for (var photo in photosList) {
        photos.add("https://picsum.photos/id/${photo['id']}/640/480");
      }
    }
    notifyListeners();
    return photos;
  }
}

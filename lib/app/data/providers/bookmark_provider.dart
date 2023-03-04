import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/bookmark_model.dart';

class BookmarkProvider extends GetConnect {
  static BookmarkProvider get to => Get.find();

  Future<List<Bookmark>> getBookmarks() async {
    final response = jsonDecode(await rootBundle.loadString('assets/bookmark.json'));
    if (response != null) {
      return response.map<Bookmark>((json) => Bookmark.fromJson(json)).toList();
    } else {
      throw const FileSystemException('Failed to load bookmarks');
    }
  }

  //TODO: Implement the following methods
  // Future saveBookmark(List<Bookmark> bookmark) async => {};
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/bookmark_data_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

import '../models/adapter_models/bookmark_model.dart';

class BookmarkProvider extends GetLifeCycle {
  static BookmarkProvider get to => Get.find();

  late WalkProvider _walkProvider;

  @override
  void onInit() {
    _walkProvider = Get.find<WalkProvider>();
  }

  Future<List<Bookmark>> getBookmarks() async {

    final response = jsonDecode(await rootBundle.loadString('assets/bookmark.json'));
    if (response != null) {
      var bookmarkDataList = response.map<BookmarkData>((json) => BookmarkData.fromJson(json)).toList();
      var bookmarkList = <Bookmark>[];

      for (BookmarkData data in bookmarkDataList) {
        var walk = await _walkProvider.getWalk(data.walkId);
        if (walk != null) {
          bookmarkList.add(Bookmark.fromData(data, walk));
        }
      }
      return bookmarkList;
    } else {
      throw const FileSystemException('Failed to load bookmarks');
    }
  }

  //TODO: Implement the following methods
  // Future saveBookmark(List<Bookmark> bookmark) async => {};
}

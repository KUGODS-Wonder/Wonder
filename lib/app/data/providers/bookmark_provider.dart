import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/bookmark_data_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

import '../models/adapter_models/bookmark_model.dart';

class BookmarkProvider extends GetLifeCycle {
  static BookmarkProvider get to => Get.find();

  late WalkProvider _walkProvider;
  bool _hasPendingRequest = false;

  @override
  void onInit() {
    _walkProvider = Get.find<WalkProvider>();
  }

  Future<List<Bookmark>?> getBookmarks(double lat, double lng) async {
    if (_hasPendingRequest) return null;
    _hasPendingRequest = true;

    final response = jsonDecode(await rootBundle.loadString('assets/bookmark.json'));
    if (response != null) {
      var bookmarkDataList = response.map<BookmarkData>((json) => BookmarkData.fromJson(json)).toList();
      var bookmarkList = <Bookmark>[];
      List<Future<Walk?>> futures = [];

      for (BookmarkData data in bookmarkDataList) {
        futures.add(_walkProvider.getWalk(data.walkId, lat, lng));
      }

      var walks = await Future.wait(futures);
      for (Walk? walk in walks) {
        if (walk != null) {
          bookmarkList.add(Bookmark.fromData(bookmarkDataList[walks.indexOf(walk)], walk));
        }
      }
      bookmarkList.sort((a, b) => a.id.compareTo(b.id));

      _hasPendingRequest = false;
      return bookmarkList;
    } else {
      _hasPendingRequest = false;
      throw const FileSystemException('Failed to load bookmarks');
    }
  }

  Future saveBookmark(List<Bookmark> bookmark) async {

  }
}

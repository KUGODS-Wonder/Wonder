import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/errors/api_error.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/bookmark_data_model.dart';
import 'package:wonder_flutter/app/data/providers/walk_provider.dart';

import '../models/adapter_models/bookmark_model.dart';

class BookmarkProvider extends GetLifeCycle {
  static BookmarkProvider get to => Get.find();

  final HttpProvider _httpProvider = Get.find<HttpProvider>();
  final WalkProvider _walkProvider = Get.find<WalkProvider>();
  bool _hasPendingRequest = false;

  @override
  void onInit() {
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
      return null;
    }
  }

  Future<bool> saveBookmark({required int walkId, required String title, String? contents}) async {
    String? errorMessage;

    try {
      var response = await _httpProvider.httpPost(Constants.bookmarkUrl, {
        'walkId': walkId,
        'title': title,
        'contents': contents
      });
      if (response.success) {
        return true;
      } else {
        errorMessage = response.message.isNotEmpty ? response.message : null;
      }
    } on ApiError catch (ae) {
      errorMessage = ae.message;
    } catch (e) {
      errorMessage = 'Unknown Error.';
    }

    return Future.error(errorMessage ?? 'Unknown Error.');
  }
}

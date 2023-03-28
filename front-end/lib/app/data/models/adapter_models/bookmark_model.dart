import 'package:wonder_flutter/app/data/models/bookmark_data_model.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';

class Bookmark {
  int id;
  String title;
  String description;
  Walk walk;

  Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.walk});

  factory Bookmark.fromData(BookmarkData data, Walk walk) {
    return Bookmark(
      id: data.bookmarkId,
      title: data.title,
      description: data.contents ?? '',
      walk: walk,
    );
  }
}

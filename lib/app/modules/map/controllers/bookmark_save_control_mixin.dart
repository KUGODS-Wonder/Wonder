import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/providers/bookmark_provider.dart';
import 'package:wonder_flutter/app/modules/widgets/sliding_up_panel.dart';

mixin BookmarkSaveControlMixin on GetxController {
  static const Duration _slidingDuration = Duration(milliseconds: 500);

  final bookmarkSavePanelController = SlidingUpPanelController(duration: _slidingDuration);
  final _bookmarkProvider = BookmarkProvider.to;
  final _bookmarkTitleTextController = TextEditingController();
  final _bookmarkDescriptionTextController = TextEditingController();

  TextEditingController get bookmarkTitleTextController => _bookmarkTitleTextController;
  TextEditingController get bookmarkDescriptionTextController => _bookmarkDescriptionTextController;


  @override
  void onClose() {
    _bookmarkTitleTextController.dispose();
    _bookmarkDescriptionTextController.dispose();
    bookmarkSavePanelController.dispose();
    super.onClose();
  }

  void saveWalkAsBookmark(
    Walk walk,
    {void Function()? onTitleTextEmpty,
    void Function()? onSuccess,
    void Function(dynamic)? onError}
    ) async {
    if (_bookmarkTitleTextController.text.isEmpty) {
      if (onTitleTextEmpty != null) onTitleTextEmpty();
      return;
    }

    bool isSuccess = await _bookmarkProvider.saveBookmark(
      walkId: walk.id,
      title: _bookmarkTitleTextController.text,
      contents: _bookmarkDescriptionTextController.text,
    ).catchError((error) {
      if (onError != null) onError(error);
      return false;
    });

    if (isSuccess) {
      if (onSuccess != null) onSuccess();
    }
  }

  void setBookmarkTitleText(String text) {
    _bookmarkTitleTextController.text = text;
  }
}
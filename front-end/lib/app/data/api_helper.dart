import 'package:get/get.dart';

export 'package:wonder_flutter/app/common/util/extensions.dart';
export 'package:wonder_flutter/app/common/util/utils.dart';

abstract class ApiHelper {
  static ApiHelper get to => Get.find();

  Future<Response> getPosts();
}

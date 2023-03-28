import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/constants.dart';
import 'package:wonder_flutter/app/data/http_provider.dart';
import '../models/nickname_check_data_model.dart';

class NicknameCheckProvider extends GetLifeCycle {
  static HttpProvider httpProvider = Get.find<HttpProvider>();
  @override
  void onInit() {
    super.onInit();
  }

  Future<NicknameCheckData?> getNickNameCheckResponse(String name) async {
    var response =
        await httpProvider.httpGet('${Constants.nicknameCheckUrl}/${name}');

    if (response.success) {
      try {
        return NicknameCheckData.fromJson(response.data);
      } catch (e) {
        return Future.error('parsing nicknameCheckData failed.');
      }
    }
    return Future.error(response.message);
  }
}

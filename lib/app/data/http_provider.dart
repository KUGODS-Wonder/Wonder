import 'package:get/get.dart' as getx;

abstract class HttpProvider {
  static HttpProvider get to => getx.Get.find();

  Future<dynamic> httpGet(String path, Map<String, dynamic> queryParameters);
  Future<dynamic> httpPost(
    String path,
    Map<String, dynamic> body,
    {Map<int, void Function(dynamic)>? onErrorMap,
    }
  );

  void setToken(String token);
}
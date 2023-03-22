import 'package:get/get.dart' as getx;
import 'package:wonder_flutter/app/data/models/base_model/http_response_model.dart';

abstract class HttpProvider {
  static HttpProvider get to => getx.Get.find();

  Future<HttpResponse> httpGet(String path,
      {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body
      });
  Future<HttpResponse> httpPost(
      String path,
      Map<String, dynamic> body,
      );
  Future<HttpResponse> httpDelete(
      String path,
      {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body
      });

  void setToken(String token);

  void setHeader(String key, String value);

  void removeHeader(String key);
}
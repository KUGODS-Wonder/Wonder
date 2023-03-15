abstract class Constants {
  static const String baseUrl = 'http://ku-wonder.shop/api/v1';
  static const String signInUrl = 'http://ku-wonder.shop/api/v1/auth/signin';
  static const String signUpUrl = 'http://ku-wonder.shop/api/v1/auth/signup';

  static const timeout = Duration(seconds: 5);
  static const splashTime = Duration(seconds: 2);
  static const String token = 'authToken';

  static const String dummyImageUrl =
      'https://i.picsum.photos/id/1084/536/354.jpg'
      '?grayscale&hmac=Ux7nzg19e1q35mlUVZjhCLxqkR30cC-CarVg-nlIf60';
  static const String placeHolderBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  static const double initialZoomLevel = 16.0;

  static const double defaultHorizontalPadding = 24.0;
}

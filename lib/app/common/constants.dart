abstract class Constants {
  static const String baseUrl = 'https://ku-wonder.shop';
  static const String apiVersion = '/api/v1';
  static const String signInUrl = '$apiVersion/auth/signin';
  static const String signUpUrl = '$apiVersion/auth/signup';
  static const String walkUrl = '$apiVersion/walk';
  static const String bookmarkUrl = '$apiVersion/bookmarks';
  static const String bookmarkDeleteUrl = '$bookmarkUrl/delete';

  static const timeout = Duration(seconds: 5);
  static const splashTime = Duration(seconds: 2);
  static const String token = 'authToken';

  static const String dummyImageUrl =
      'https://i.picsum.photos/id/1084/536/354.jpg'
      '?grayscale&hmac=Ux7nzg19e1q35mlUVZjhCLxqkR30cC-CarVg-nlIf60';
  static const String placeHolderBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  static const double initialZoomLevel = 1.0;

  static const double defaultHorizontalPadding = 24.0;

  static const double defaultVerticalPadding = 12.0;

  static int minWalkSpeedMeterPerMinute = 50; // 시속 3km/h
  static int maxWalkSpeedMeterPerMinute = 217; // 시속 13km/h

}

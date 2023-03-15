abstract class Converters {
  static String convertDurationToString(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
}
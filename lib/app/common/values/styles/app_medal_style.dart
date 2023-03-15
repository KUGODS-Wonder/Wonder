abstract class AppMedalStyle {

  static const inferrableMedalTypes = [
    '완벽한 한주',
    '완벽한 한달',
    '완벽한 한해'
  ];

  static const defaultWalkTagStyle = MedalStyleModel(
      imagePath: 'assets/images/medals/medal.png'
  );

  static final Map<String, MedalStyleModel> _dict = {
    '완벽한 한주': const MedalStyleModel(
        imagePath: 'assets/images/medals/medal.png',
    ),
  };

  static MedalStyleModel getStyle(String medalName) {
    var inferredMedalType = medalName;

    for (var inferrableMedalType in inferrableMedalTypes) {
      if (medalName.contains(inferrableMedalType)) {
        inferredMedalType = inferrableMedalType;
        break;
      }
    }

    return _dict[inferredMedalType] ?? defaultWalkTagStyle;
  }
}

class MedalStyleModel {
  final String imagePath;

  const MedalStyleModel({required this.imagePath});
}
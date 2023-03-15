class Profile {
  String email;
  String nickname;
  String rank;
  int ratingToNextRank;
  int currentRating;
  int hoursWalked;
  int totalDistanceWalked;
  List<Medal> medal;

  Profile({
    required this.email,
    required this.nickname,
    required this.rank,
    required this.ratingToNextRank,
    required this.currentRating,
    required this.hoursWalked,
    required this.totalDistanceWalked,
    required this.medal});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'],
      nickname: json['nickname'],
      rank: json['rank'],
      ratingToNextRank: json['ratingToNextRank'],
      currentRating: json['currentRating'],
      hoursWalked: json['hoursWalked'],
      totalDistanceWalked: json['totalDistanceWalked'],
      medal: json['medal'] != null
          ? (json['medal'] as List).map((i) => Medal.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['nickname'] = nickname;
    data['rank'] = rank;
    data['ratingToNextRank'] = ratingToNextRank;
    data['currentRating'] = currentRating;
    data['hoursWalked'] = hoursWalked;
    data['totalDistanceWalked'] = totalDistanceWalked;
    data['medal'] = medal.map((v) => v.toJson()).toList();
    return data;
  }
}

class Medal {
  String title;
  String description;
  DateTime date;
  String? comments;

  Medal({
    required this.title,
    required this.description,
    required this.date,
    this.comments});

  factory Medal.fromJson(Map<String, dynamic> json) {
    return Medal(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['comments'] = comments;
    return data;
  }
}

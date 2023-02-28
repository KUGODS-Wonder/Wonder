class LeaderboardData {
  String location;
  int month;
  int week;
  int myRank;
  int myDistance;
  List<Rank> rank;

  LeaderboardData({
    required this.location,
    required this.month,
    required this.week,
    required this.myRank,
    required this.myDistance,
    required this.rank});

  factory LeaderboardData.fromJson(Map<String, dynamic> json) {
    return LeaderboardData(
      location: json['location'],
      month: json['month'],
      week: json['week'],
      myRank: json['myRank'],
      myDistance: json['myDistance'],
      rank: json['rank'] != null
          ? (json['rank'] as List).map((i) => Rank.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['location'] = location;
    data['month'] = month;
    data['week'] = week;
    data['myRank'] = myRank;
    data['myDistance'] = myDistance;
    data['rank'] = rank.map((v) => v.toJson()).toList();
    return data;
  }
}

class Rank {
  String nickname;
  int distance;

  Rank({required this.nickname, required this.distance});

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      nickname: json['nickname'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['distance'] = distance;
    return data;
  }
}

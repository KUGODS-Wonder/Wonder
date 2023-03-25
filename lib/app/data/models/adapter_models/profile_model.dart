import 'package:wonder_flutter/app/data/models/profile_data_model.dart';

class Profile {
  String email;
  String nickname;
  String rank;
  int ratingToNextRank;
  int currentRating;
  int hoursWalked;
  int totalDistanceWalked;
  LeaderboardInfo leaderboardInfo;
  List<Medal> medal;

  Profile({
    required this.email,
    required this.nickname,
    required this.rank,
    required this.ratingToNextRank,
    required this.currentRating,
    required this.hoursWalked,
    required this.totalDistanceWalked,
    required this.leaderboardInfo,
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
      leaderboardInfo: LeaderboardInfo.fromJson(json['leaderboardInfo']),
      medal: json['medal'] != null
          ? (json['medal'] as List).map((i) => Medal.fromJson(i)).toList()
          : [],
    );
  }

  factory Profile.fromData(ProfileData data) {
    return Profile(
      email: data.email,
      nickname: data.name,
      rank: data.tierInfo.tierName,
      ratingToNextRank: data.tierInfo.minPointToUpgrade,
      currentRating: data.totalPoint,
      hoursWalked: data.totalWalkingTime ~/ 3600,
      totalDistanceWalked: (data.totalDistance * 1000).round(),
      leaderboardInfo: LeaderboardInfo(
        location: data.address,
        month: 0,
        week: 0,
        myRank: data.myRanking,
        myDistance: (data.totalDistance * 1000).round(),
        rank: data.localRankingTopFive
            .map((e) => Rank(
                  nickname: e.name,
                  distance: (e.totalDistance * 1000).round(),
                ))
            .toList(),
      ),
      medal: [],
    );
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


class LeaderboardInfo {
  String location;
  int month;
  int week;
  int myRank;
  int myDistance;
  List<Rank> rank;

  LeaderboardInfo({
    required this.location,
    required this.month,
    required this.week,
    required this.myRank,
    required this.myDistance,
    required this.rank});

  factory LeaderboardInfo.fromJson(Map<String, dynamic> json) {
    return LeaderboardInfo(
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
class ProfileData {
  int memberId;
  String name;
  String email;
  String address;
  TierInfo tierInfo;
  int totalPoint;
  double totalDistance;
  int totalWalkingTime;
  int myRanking;
  List<LocalRankingTopFive> localRankingTopFive;

  ProfileData(
      {required this.memberId,
      required this.name,
      required this.email,
      required this.address,
      required this.tierInfo,
      required this.totalPoint,
      required this.totalDistance,
      required this.totalWalkingTime,
      required this.myRanking,
      required this.localRankingTopFive});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      memberId: json['memberId'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      tierInfo: TierInfo.fromJson(json['tierInfo']),
      totalPoint: json['totalPoint'],
      totalDistance: json['totalDistance'],
      totalWalkingTime: json['totalWalkingTime'],
      myRanking: json['myRanking'],
      localRankingTopFive: json['localRankingTopFive'] != null
          ? (json['localRankingTopFive'] as List)
              .map((i) => LocalRankingTopFive.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['tierInfo'] = tierInfo.toJson();
    data['totalPoint'] = totalPoint;
    data['totalDistance'] = totalDistance;
    data['totalWalkingTime'] = totalWalkingTime;
    data['myRanking'] = myRanking;
    data['localRankingTopFive'] =
        localRankingTopFive.map((v) => v.toJson()).toList();
    return data;
  }
}

class TierInfo {
  String tierName;
  int minPointToUpgrade;

  TierInfo({
    required this.tierName,
    required this.minPointToUpgrade});

  factory TierInfo.fromJson(Map<String, dynamic> json) {
    return TierInfo(
      tierName: json['tierName'],
      minPointToUpgrade: json['minPointToUpgrade'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tierName'] = tierName;
    data['minPointToUpgrade'] = minPointToUpgrade;
    return data;
  }
}

class LocalRankingTopFive {
  int memberId;
  String name;
  double totalDistance;
  int ranking;

  LocalRankingTopFive(
      {required this.memberId,
      required this.name,
      required this.totalDistance,
      required this.ranking});

  factory LocalRankingTopFive.fromJson(Map<String, dynamic> json) {
    return LocalRankingTopFive(
      memberId: json['memberId'],
      name: json['name'],
      totalDistance: json['totalDistance'],
      ranking: json['ranking'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['name'] = name;
    data['totalDistance'] = totalDistance;
    data['ranking'] = ranking;
    return data;
  }
}

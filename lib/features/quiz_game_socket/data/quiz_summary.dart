class QuizSummary {
  final TopUsers topUsers;
  final UserResult userResult;

  QuizSummary({required this.topUsers, required this.userResult});

  // Factory method for deserialization (from JSON)
  factory QuizSummary.fromJson(Map<String, dynamic> json) {
    return QuizSummary(
      topUsers: TopUsers.fromJson(json['topUsers']),
      userResult: UserResult.fromJson(json['userResult']),
    );
  }

  // Method for serialization (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'topUsers': topUsers.toJson(),
      'userResult': userResult.toJson(),
    };
  }
}

class TopUsers {
  final List<TopUser> data;
  final int totalUser;
  final int page;
  final int perPage;

  TopUsers({
    required this.data,
    required this.totalUser,
    required this.page,
    required this.perPage,
  });

  factory TopUsers.fromJson(Map<String, dynamic> json) {
    return TopUsers(
      data: List<TopUser>.from(json['data'].map((x) => TopUser.fromJson(x))),
      totalUser: json['totalUser'],
      page: json['page'],
      perPage: json['perPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((x) => x.toJson()).toList(),
      'totalUser': totalUser,
      'page': page,
      'perPage': perPage,
    };
  }
}

class TopUser {
  final String userId;
  final String gameOfEventId;
  final int score;
  final int top;

  TopUser({
    required this.userId,
    required this.gameOfEventId,
    required this.score,
    required this.top,
  });

  factory TopUser.fromJson(Map<String, dynamic> json) {
    return TopUser(
      userId: json['userId'],
      gameOfEventId: json['gameOfEventId'],
      score: json['score'],
      top: json['top'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'gameOfEventId': gameOfEventId,
      'score': score,
      'top': top,
    };
  }
}

class UserResult {
  final int score;
  final int top;

  UserResult({required this.score, required this.top});

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      score: json['score'],
      top: json['top'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'top': top,
    };
  }
}

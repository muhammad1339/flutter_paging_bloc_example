// To parse this JSON data, do
//
//     final getAnswersResponse = getAnswersResponseFromJson(jsonString);

import 'dart:convert';

GetAnswersResponse getAnswersResponseFromJson(String str) =>
    GetAnswersResponse.fromJson(json.decode(str));

String getAnswersResponseToJson(GetAnswersResponse data) =>
    json.encode(data.toJson());

class GetAnswersResponse {
  GetAnswersResponse({
    required this.items,
  });

  List<Item> items;

  factory GetAnswersResponse.fromJson(Map<String, dynamic> json) =>
      GetAnswersResponse(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.owner,
    required this.isAccepted,
    required this.score,
    required this.lastActivityDate,
    required this.creationDate,
    required this.answerId,
    required this.questionId,
    required this.contentLicense,
  });

  Owner? owner;
  bool isAccepted;
  int score;
  int lastActivityDate;
  int creationDate;
  int answerId;
  int questionId;
  String contentLicense;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        owner: Owner.fromJson(json["owner"]),
        isAccepted: json["is_accepted"],
        score: json["score"],
        lastActivityDate: json["last_activity_date"],
        creationDate: json["creation_date"],
        answerId: json["answer_id"],
        questionId: json["question_id"],
        contentLicense: json["content_license"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner?.toJson(),
        "is_accepted": isAccepted,
        "score": score,
        "last_activity_date": lastActivityDate,
        "creation_date": creationDate,
        "answer_id": answerId,
        "question_id": questionId,
        "content_license": contentLicense,
      };
}

class Owner {
  Owner({
    required this.accountId,
    required this.reputation,
    required this.userId,
    required this.userType,
    required this.profileImage,
    required this.displayName,
    required this.link,
  });

  int accountId;
  int reputation;
  int userId;
  String userType;
  String profileImage;
  String displayName;
  String link;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        accountId: json["account_id"],
        reputation: json["reputation"],
        userId: json["user_id"],
        userType: json["user_type"],
        profileImage: json["profile_image"],
        displayName: json["display_name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "reputation": reputation,
        "user_id": userId,
        "user_type": userType,
        "profile_image": profileImage,
        "display_name": displayName,
        "link": link,
      };
}

import 'package:Okuna/models/badge.dart';

class BadgesList {
  final List<PictofeedBadge>? badges;

  BadgesList({
    this.badges,
  });

  factory BadgesList.fromJson(List<dynamic> parsedJson) {
    List<PictofeedBadge> badges =
        parsedJson.map((badgeJson) => PictofeedBadge.fromJson(badgeJson)).toList();

    return new BadgesList(
      badges: badges,
    );
  }
}

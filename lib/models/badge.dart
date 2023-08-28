class PictofeedBadge {
  final PictofeedBadgeKeyword? keyword;
  final String? keywordDescription;

  PictofeedBadge(
      {this.keyword,
       this.keywordDescription,
      });

  factory PictofeedBadge.fromJson(Map<String, dynamic> parsedJson) {
    return PictofeedBadge(
        keyword: PictofeedBadgeKeyword.parse(parsedJson['keyword']),
        keywordDescription: parsedJson['keyword_description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword.toString(),
      'keyword_description': keywordDescription
    };
  }

  PictofeedBadgeKeyword? getKeyword() {
    return this.keyword;
  }

  String? getKeywordDescription() {
    return this.keywordDescription;
  }
}


class PictofeedBadgeKeyword {
  // Using a custom-built enum class to link the notification type strings
  // directly to the matching enum constants.
  // This class can still be used in switch statements as a normal enum.
  final String code;

  const PictofeedBadgeKeyword._internal(this.code);

  toString() => code;

  static const angel = const PictofeedBadgeKeyword._internal('ANGEL');
  static const verified = const PictofeedBadgeKeyword._internal('VERIFIED');
  static const founder = const PictofeedBadgeKeyword._internal('FOUNDER');
  static const golden_founder = const PictofeedBadgeKeyword._internal('GOLDEN_FOUNDER');
  static const diamond_founder = const PictofeedBadgeKeyword._internal('DIAMOND_FOUNDER');
  static const super_founder = const PictofeedBadgeKeyword._internal('SUPER_FOUNDER');

  static const _values = const <PictofeedBadgeKeyword>[
    angel,
    verified,
    founder,
    golden_founder,
    diamond_founder,
    super_founder
  ];

  static values() => _values;

  static PictofeedBadgeKeyword? parse(String? string) {
    if (string == null) return null;

    PictofeedBadgeKeyword? badgeKeyword;

    for (var keyword in _values) {
      if (string == keyword.code) {
        badgeKeyword = keyword;
        break;
      }
    }

    if (badgeKeyword == null) {
      print('Unsupported badge keyword');
    }

    return badgeKeyword;
  }
}

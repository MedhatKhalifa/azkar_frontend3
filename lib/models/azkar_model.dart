class Azkar {
  final String? category;
  final String? subCategory;
  final String? content;
  final String? before;
  final String? after;
  int? count;
  int? initialCount;
  final String? reward;
  final String? whenToSay;
  final String? whereToSay;
  final String? why;
  final String? source;
  final String? comment;
  final String? language;
  final String? iconName;

  Azkar({
    this.category,
    this.subCategory,
    this.content,
    this.before,
    this.after,
    this.count,
    this.reward,
    this.whenToSay,
    this.whereToSay,
    this.why,
    this.source,
    this.comment,
    this.language,
    this.iconName,
    this.initialCount,
  });

  factory Azkar.fromJson(Map<String, dynamic> json) {
    return Azkar(
      category: json['category'],
      subCategory: json['sub_category'],
      content: json['content'],
      before: json['before'],
      after: json['after'],
      count: json['count'],
      initialCount: json['count'],
      reward: json['reward'],
      whenToSay: json['when'],
      whereToSay: json['where'],
      why: json['why'],
      source: json['source'],
      comment: json['comment'],
      language: json['language'],
      iconName: json['icon_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'sub_category': subCategory,
      'content': content,
      'before': before,
      'after': after,
      'count': count,
      'reward': reward,
      'when': whenToSay,
      'where': whereToSay,
      'why': why,
      'source': source,
      'comment': comment,
      'language': language,
      'icon_name': iconName,
    };
  }
}

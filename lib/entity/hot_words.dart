import 'package:json_annotation/json_annotation.dart';

part 'hot_words.g.dart';

@JsonSerializable()
class HotWords extends Object {
  Data data;

  String message;

  HotWords(
    this.data,
    this.message,
  );

  factory HotWords.fromJson(Map<String, dynamic> srcJson) =>
      _$HotWordsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWordsToJson(this);
}

@JsonSerializable()
class Data extends Object {
  int call_per_refresh;

  String homepage_search_suggest;

  List<Suggest_words> suggest_words;

  Data(
    this.call_per_refresh,
    this.homepage_search_suggest,
    this.suggest_words,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Suggest_words extends Object {
  String id;

  String or;

  String recommend_reason;

  String word;

  Suggest_words(
    this.id,
    this.or,
    this.recommend_reason,
    this.word,
  );

  factory Suggest_words.fromJson(Map<String, dynamic> srcJson) =>
      _$Suggest_wordsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Suggest_wordsToJson(this);
}

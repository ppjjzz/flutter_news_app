// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_words.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWords _$HotWordsFromJson(Map<String, dynamic> json) {
  return HotWords(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['message'] as String);
}

Map<String, dynamic> _$HotWordsToJson(HotWords instance) =>
    <String, dynamic>{'data': instance.data, 'message': instance.message};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['call_per_refresh'] as int,
      json['homepage_search_suggest'] as String,
      (json['suggest_words'] as List)
          ?.map((e) => e == null
              ? null
              : Suggest_words.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'call_per_refresh': instance.call_per_refresh,
      'homepage_search_suggest': instance.homepage_search_suggest,
      'suggest_words': instance.suggest_words
    };

Suggest_words _$Suggest_wordsFromJson(Map<String, dynamic> json) {
  return Suggest_words(json['id'] as String, json['or'] as String,
      json['recommend_reason'] as String, json['word'] as String);
}

Map<String, dynamic> _$Suggest_wordsToJson(Suggest_words instance) =>
    <String, dynamic>{
      'id': instance.id,
      'or': instance.or,
      'recommend_reason': instance.recommend_reason,
      'word': instance.word
    };

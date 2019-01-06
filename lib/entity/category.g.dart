// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
      json['message'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['version'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : DataBody.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'version': instance.version, 'data': instance.data};

DataBody _$DataBodyFromJson(Map<String, dynamic> json) {
  return DataBody(
      json['category'] as String,
      json['web_url'] as String,
      json['flags'] as int,
      json['name'] as String,
      json['tip_new'] as int,
      json['default_add'] as int,
      json['concern_id'] as String,
      json['type'] as int,
      json['icon_url'] as String);
}

Map<String, dynamic> _$DataBodyToJson(DataBody instance) => <String, dynamic>{
      'category': instance.category,
      'web_url': instance.webUrl,
      'flags': instance.flags,
      'name': instance.name,
      'tip_new': instance.tipNew,
      'default_add': instance.defaultAdd,
      'concern_id': instance.concernId,
      'type': instance.type,
      'icon_url': instance.iconUrl
    };

import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Object {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  Data data;

  Category(
    this.message,
    this.data,
  );

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'data')
  List<DataBody> data;

  Data(
    this.version,
    this.data,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DataBody extends Object {
  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'web_url')
  String webUrl;

  @JsonKey(name: 'flags')
  int flags;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'tip_new')
  int tipNew;

  @JsonKey(name: 'default_add')
  int defaultAdd;

  @JsonKey(name: 'concern_id')
  String concernId;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'icon_url')
  String iconUrl;

  DataBody(
    this.category,
    this.webUrl,
    this.flags,
    this.name,
    this.tipNew,
    this.defaultAdd,
    this.concernId,
    this.type,
    this.iconUrl,
  );

  factory DataBody.fromJson(Map<String, dynamic> srcJson) =>
      _$DataBodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataBodyToJson(this);
}

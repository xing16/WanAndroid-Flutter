import 'package:json_annotation/json_annotation.dart';

part 'meizi.g.dart';

@JsonSerializable()
class Meizi extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'publishedAt')
  String publishedAt;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'used')
  bool used;

  @JsonKey(name: 'who')
  String who;

  Meizi(
    this.id,
    this.createdAt,
    this.desc,
    this.publishedAt,
    this.source,
    this.type,
    this.url,
    this.used,
    this.who,
  );

  factory Meizi.fromJson(Map<String, dynamic> srcJson) =>
      _$MeiziFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MeiziToJson(this);
}

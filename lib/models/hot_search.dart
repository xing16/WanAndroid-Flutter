import 'package:json_annotation/json_annotation.dart';

part 'hot_search.g.dart';

@JsonSerializable()
class HotSearch extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'visible')
  int visible;

  HotSearch(
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  );

  factory HotSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$HotSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotSearchToJson(this);
}

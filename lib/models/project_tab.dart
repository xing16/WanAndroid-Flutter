import 'package:json_annotation/json_annotation.dart';

part 'project_tab.g.dart';

@JsonSerializable()
class ProjectTab extends Object {
  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  ProjectTab(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory ProjectTab.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectTabFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectTabToJson(this);
}

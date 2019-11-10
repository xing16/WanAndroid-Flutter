// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemCategory _$SystemCategoryFromJson(Map<String, dynamic> json) {
  return SystemCategory(
    (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : SystemCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['courseId'] as int,
    json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
  );
}

Map<String, dynamic> _$SystemCategoryToJson(SystemCategory instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };

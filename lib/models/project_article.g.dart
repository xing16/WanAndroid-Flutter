// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectArticle _$ProjectArticleFromJson(Map<String, dynamic> json) {
  return ProjectArticle(
    json['curPage'] as int,
    (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$ProjectArticleToJson(ProjectArticle instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    json['name'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

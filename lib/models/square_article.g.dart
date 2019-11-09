// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'square_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquareArticle _$SquareArticleFromJson(Map<String, dynamic> json) {
  return SquareArticle(
    json['curPage'] as int,
    json['article'] as List,
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$SquareArticleToJson(SquareArticle instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'article': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };

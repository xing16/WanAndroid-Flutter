import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid_flutter/models/article.dart';

part 'project_article.g.dart';

@JsonSerializable()
class ProjectArticle extends Object {
  @JsonKey(name: 'curPage')
  int curPage;

  @JsonKey(name: 'datas')
  List<Article> datas;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'over')
  bool over;

  @JsonKey(name: 'pageCount')
  int pageCount;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'total')
  int total;

  ProjectArticle(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory ProjectArticle.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectArticleToJson(this);
}

@JsonSerializable()
class Tags extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  Tags(
    this.name,
    this.url,
  );

  factory Tags.fromJson(Map<String, dynamic> srcJson) =>
      _$TagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}

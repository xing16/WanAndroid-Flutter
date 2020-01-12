import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid_flutter/models/article.dart';

part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse extends Object {
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

  ArticleResponse(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory ArticleResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}

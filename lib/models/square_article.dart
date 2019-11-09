import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'square_article.g.dart';

@JsonSerializable()
class SquareArticle extends Object {
  @JsonKey(name: 'curPage')
  int curPage;

  @JsonKey(name: 'article')
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

  SquareArticle(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory SquareArticle.fromJson(Map<String, dynamic> srcJson) =>
      _$SquareArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SquareArticleToJson(this);
}

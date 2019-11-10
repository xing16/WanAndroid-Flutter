import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid_flutter/models/article.dart';

part 'square_article.g.dart';

@JsonSerializable()
class SystemArticle extends Object {
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

  SystemArticle(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory SystemArticle.fromJson(Map<String, dynamic> srcJson) =>
      _$SystemArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SystemArticleToJson(this);

  @override
  String toString() {
    return 'SquareArticle{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }
}

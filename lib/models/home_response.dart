import 'article.dart';

class HomeArticleResponse {
  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<Article> datas;

  HomeArticleResponse(
      {this.over,
      this.pageCount,
      this.total,
      this.curPage,
      this.offset,
      this.size,
      this.datas});

  HomeArticleResponse.fromJson(Map<String, dynamic> json) {
    over = json['over'];
    pageCount = json['pageCount'];
    total = json['total'];
    curPage = json['curPage'];
    offset = json['offset'];
    size = json['size'];
    if (json['datas'] != null) {
      datas = new List<Article>();
      (json['datas'] as List).forEach((v) {
        datas.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['size'] = this.size;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

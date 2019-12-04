import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/project_article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/utils/screen_utils.dart';

class ProjectListPage extends StatefulWidget {
  final int curPage = 0;
  final int tabId;

  ProjectListPage(this.tabId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectListPageState();
  }
}

class ProjectListPageState extends State<ProjectListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Article> articleList = new List();
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    loadProjectList(widget.tabId, widget.curPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenWidth = ScreenUtils.getScreenWidth(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        return getProjectListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 12,
          endIndent: 12,
          height: 0.5,
        );
      },
      itemCount: articleList.length,
    );
  }

  /// 请求 tab 下的列表
  void loadProjectList(int tabId, int page) {
    HttpClient.getInstance().get(Api.PROJECT_LIST,
        data: {"page": page, "cid": tabId}, callback: (data) {
      ProjectArticle projectArticle = ProjectArticle.fromJson(data);
      setState(() {
        articleList = projectArticle?.datas;
      });
    });
  }

  /// ListView item
  getProjectListItem(int position) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onProjectArticleClick(position);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Theme.of(context).accentColor,
        child: Row(
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "images/placeholder.png",
              width: 90,
              height: 66,
              image: articleList[position].envelopePic,
              fit: BoxFit.cover,
            ),
            Container(
              height: 66,
              width: screenWidth - 124,
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text(
                              articleList[position].title,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            articleList[position].author,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(articleList[position].niceDate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onProjectArticleClick(int position) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: articleList[position].link,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/project_article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/utils/screen_utils.dart';

class ProjectListPage extends StatefulWidget {
  final int tabId;

  ProjectListPage(this.tabId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectListPageState();
  }
}

class ProjectListPageState extends State<ProjectListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int curPage = 0;
  List<Article> articleList = new List();
  double screenWidth = 0;
  EasyRefreshController _controller = new EasyRefreshController();

  @override
  void initState() {
    super.initState();
    loadProjectList(widget.tabId, 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenWidth = ScreenUtils.getScreenWidth(context);
    return EasyRefresh(
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(
        noMoreText: "到底了",
      ),
      onRefresh: () async {
        loadProjectList(widget.tabId, 0);
      },
      onLoad: () async {
        loadProjectList(widget.tabId, curPage);
      },
      child: ListView.separated(
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
      ),
    );
  }

  /// 请求 tab 下的列表
  void loadProjectList(int tabId, int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.PROJECT_LIST, data: {"page": page, "cid": tabId});
    ProjectArticle projectArticle = ProjectArticle.fromJson(result);
    curPage = page + 1;
    print("data = ${projectArticle.datas}");
    setState(() {
      if (page == 0) {
        articleList.clear();
      }
      articleList.addAll(projectArticle?.datas);
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

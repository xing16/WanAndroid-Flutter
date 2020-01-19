import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int tabId = 0;
  List<Article> articleList = new List();
  double screenWidth = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    tabId = widget.tabId;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenWidth = getScreenWidth(context);
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("上拉加载更多");
          } else {
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return createProjectListItem(index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            color: Colors.black12,
            height: 0.5,
          );
        },
        itemCount: articleList.length,
      ),
    );
  }

  /// ListView item
  createProjectListItem(int position) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onProjectArticleClick(position);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Theme.of(context).backgroundColor,
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
                            articleList[position].author.isEmpty
                                ? articleList[position].shareUser
                                : articleList[position].author,
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            articleList[position].niceDate,
                            style: Theme.of(context).textTheme.body2,
                          ),
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

  /// 请求 tab 下的列表
  Future<ProjectArticle> _loadProjectList(int tabId, int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.PROJECT_LIST, data: {"page": page, "cid": tabId});
    curPage = page + 1;
    ProjectArticle projectArticle = ProjectArticle.fromJson(result);
    return projectArticle;
  }

  /// 下拉刷新
  void _onRefresh() async {
    ProjectArticle projectArticle = await _loadProjectList(tabId, 0);
    setState(() {
      articleList.clear();
      articleList.addAll(projectArticle.datas);
    });
    // 下拉刷新完成重置footer状态，否则此后无法上拉加载更多
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  /// 上拉加载更多
  void _onLoadMore() async {
    ProjectArticle projectArticle = await _loadProjectList(tabId, curPage);
    List<Article> articles = projectArticle.datas;
    if (articles.length < projectArticle.size) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
    setState(() {
      articleList.addAll(articles);
    });
  }
}

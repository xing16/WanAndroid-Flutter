class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";
  static const String GANK_URL = "http://gank.io/";

  static const String HOME_ARTICLE = "article/list/:page/json";

  // 首页 banner
  static const String BANNER = "banner/json";

  // 收藏文章列表
  static const String FAVORITE_LIST = BASE_URL + "lg/collect/list/";

  // 搜索
  static const String ARTICLE_SEARCH = BASE_URL + "article/query/";

  // 收藏,取消收藏
  static const String FAVORITE = BASE_URL + "lg/collect/";
  static const String UNCOLLECT_ORIGINID = BASE_URL + "lg/uncollect_originId/";

  // 收藏列表中取消收藏
  static const String UNCOLLECT_LIST = BASE_URL + "lg/uncollect/";

  // 登录
  static const String USER_LOGIN = BASE_URL + "user/login";

  // 注册
  static const String USER_REGISTER = BASE_URL + "user/register";

  // 知识体系
  static const String SYSTEM_CATEGORY = "tree/json";

  // 知识体系文章列表
  static const String SYSTEM_ARTICLE_LIST = "article/list/:page/json?cid=:cid";

  // 搜索热词
  static const String SEARCH_HOTKEY = BASE_URL + "hotkey/json";

  // 项目分类
  static const String PROJECT_TABS = "project/tree/json";

  // 项目分类
  static const String PROJECT_LIST = "project/list/:page/json?cid=:cid";

  // 广场
  static const String SQUARE_ARTICLE = "user_article/list/:page/json";

  // 妹子
  static const String GANK_MEIZI =
      GANK_URL + "api/data/%E7%A6%8F%E5%88%A9/:pageSize/:page";

  // 我的积分
  static const String POINTS_OWN = "lg/coin/userinfo/json";

  // 积分排行榜
  static const String POINTS_RANK = "coin/rank/:page/json";
}

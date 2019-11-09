class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";
  static const String GANK_URL = "http://gank.io/";

  static const String HOME_ARTICLE = BASE_URL + "article/list/0/json";

  // 首页 banner
  static const String BANNER = BASE_URL + "banner/json";

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
  static const String SYSTEM_CATEGORY = BASE_URL + "tree/json";

  // 搜索热词
  static const String SEARCH_HOTKEY = BASE_URL + "hotkey/json";

  // 项目分类
  static const String PROJECT_TABS = BASE_URL + "project/tree/json";

  // 广场
  static const String SQUARE_ARTICLE = BASE_URL + "user_article/list/";

  static const String GANK_MEIZI = GANK_URL + "api/data/%E7%A6%8F%E5%88%A9/";

  // 积分排行榜
  static const String POINTS_RANK = BASE_URL + "coin/rank/";
}

class HomeBanner {
  String imagePath;
  int id;
  int isVisible;
  String title;
  int type;
  String url;
  String desc;
  int order;

  HomeBanner(
      {this.imagePath,
      this.id,
      this.isVisible,
      this.title,
      this.type,
      this.url,
      this.desc,
      this.order});

  HomeBanner.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    id = json['id'];
    isVisible = json['isVisible'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    desc = json['desc'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['id'] = this.id;
    data['isVisible'] = this.isVisible;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['desc'] = this.desc;
    data['order'] = this.order;
    return data;
  }
}

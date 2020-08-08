class TopCategoriesModel {
  String name;
  int numPosts;

  TopCategoriesModel({this.name, this.numPosts});

  TopCategoriesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numPosts = json['num_posts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['num_posts'] = this.numPosts;
    return data;
  }
}
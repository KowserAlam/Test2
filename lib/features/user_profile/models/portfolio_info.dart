
class PortfolioInfo {
  String name;
  String image;
  String description;

  PortfolioInfo({this.name, this.image, this.description});

  PortfolioInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}

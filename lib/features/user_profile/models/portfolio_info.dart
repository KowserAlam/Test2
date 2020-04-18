class PortfolioInfo {
  int portfolioId;
  String name;
  Null image;
  String description;

  PortfolioInfo({this.portfolioId, this.name, this.image, this.description});

  PortfolioInfo.fromJson(Map<String, dynamic> json) {
    portfolioId = json['portfolio_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portfolio_id'] = this.portfolioId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
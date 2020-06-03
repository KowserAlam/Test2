class CareerAdviceModel {
  int id;
  String title;
  String shortDescription;
  String description;
  String author;
  String createdDate;

  CareerAdviceModel({
    this.id,
    this.title,
    this.shortDescription,
    this.description,
    this.author,
    this.createdDate,
  });
  CareerAdviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    author = json['author'];
    createdDate = json['created_date'];
  }
}





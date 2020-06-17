class CareerAdviceModel {
  int id;
  String title;
  String shortDescription;
  String description;
  String author;
  DateTime createdAt;

  CareerAdviceModel({
    this.id,
    this.title,
    this.shortDescription,
    this.description,
    this.author,
    this.createdAt,
  });
  CareerAdviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    author = json['author'];
    if(json['created_at'] != null){
      createdAt = DateTime.parse( json['created_at']);
    }

  }
}





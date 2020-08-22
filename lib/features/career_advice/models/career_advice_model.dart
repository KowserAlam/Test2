import 'package:p7app/main_app/flavour/flavour_config.dart';

class CareerAdviceModel {
  int id;
  String title;
  String shortDescription;
  String description;
  String author;
  String thumbnailImage;
  String featuredImage;
  DateTime postedAt;

  CareerAdviceModel({
    this.id,
    this.title,
    this.shortDescription,
    this.description,
    this.author,
    this.postedAt,
    this.thumbnailImage,
    this.featuredImage,
  });

  CareerAdviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    author = json['author'];
    if (json['posted_at'] != null) {
      postedAt = DateTime.parse(json['posted_at']);
    }
    if (json['thumbnail_image'] != null) {
      var baseUrl = FlavorConfig.instance.values.baseUrl;
      thumbnailImage = "$baseUrl${json['thumbnail_image']}";
    }

    if (json['featured_image'] != null) {
      var baseUrl = FlavorConfig.instance.values.baseUrl;
      featuredImage = "$baseUrl${json['featured_image']}";
    }
  }

  @override
  String toString() {
    return 'CareerAdviceModel{id: $id, title: $title, shortDescription: $shortDescription, description: $description, author: $author, thumbnailImage: $thumbnailImage, featuredImage: $featuredImage, createdAt: $postedAt}';
  }
}

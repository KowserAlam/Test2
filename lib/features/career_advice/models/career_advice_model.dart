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

List<CareerAdviceModel> adviceList = [
  CareerAdviceModel(
    title: 'Don\'t be afraid to get fired',
    author: 'Henry Ford',
    description:
        'You’ll compromise yourself and your career goals if you’re just trying to not get fired.',
    createdDate: '11TH APR, 2020',
  ),
  CareerAdviceModel(
    title: 'SKILLS OVER DEGREES',
    author: 'Elon Musk',
    description:
        'During a 2014 interview, Musk suggested young people should not be obsessed about degrees',
    createdDate: '11TH APR, 2020',
  )
];




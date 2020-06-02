class CareerAdviceModel{
  String adviceTitle;
  String author;
  String description;
  String date;

  CareerAdviceModel({
   this.description,
   this.date,
   this.adviceTitle,
   this.author
});
}

List<CareerAdviceModel> adviceList = [
  CareerAdviceModel(
    adviceTitle: 'Don\'t be afraid to get fired',
    author: 'Henry Ford',
    description: 'You’ll compromise yourself and your career goals if you’re just trying to not get fired.',
    date: '11TH APR, 2020',
  ),
  CareerAdviceModel(
    adviceTitle: 'SKILLS OVER DEGREES',
    author: 'Elon Musk',
    description: 'During a 2014 interview, Musk suggested young people should not be obsessed about degrees',
    date: '11TH APR, 2020',
  )
];
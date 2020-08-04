import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/const.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: slideImageOne,
    title: 'All jobs in one place.',
    description: '',
  ),
  Slide(
    imageUrl: slideImageTwo,
    title: 'Build your profile, fortify your career.',
    description: '',
  ),
  Slide(
    imageUrl: slideImageThree,
    title: 'Get notified of jobs best suited for you.',
    description: '',
  ),
];

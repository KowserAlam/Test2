import 'package:flutter/material.dart';

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
    imageUrl: 'assets/images/job_search_logo_sq.png',
    title: 'First page title text',
    description: 'First page description page...',
  ),
  Slide(
    imageUrl: 'assets/images/skill-check-logo.png',
    title: 'Second page title text',
    description: 'Second page description page...',
  ),
  Slide(
    imageUrl: 'assets/images/logo2.png',
    title: 'Third page title text',
    description: 'Third page description page...',
  ),
];
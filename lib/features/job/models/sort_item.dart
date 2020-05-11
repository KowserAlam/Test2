import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '';

class SortItem extends Equatable{
  String key;
  String value;

  SortItem({
    @required this.key,
    @required this.value,
  });

  @override
  // TODO: implement props
  List<Object> get props => [key,value];


}
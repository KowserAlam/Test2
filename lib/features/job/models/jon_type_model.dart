import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class JobType extends Equatable{
   String id;
   String name;

   JobType({this.id, this.name});

   JobType.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id,name];

   @override
   bool get stringify => true;
}
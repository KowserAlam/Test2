import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class Institution extends Equatable{
   int id;
   String name;

   Institution({this.id, this.name});

   Institution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id,name];

   @override
   bool get stringify => true;

   @override
   String toString() {
     return 'Institution{id: $id, name: $name}';
   }


}
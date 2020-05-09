import 'package:meta/meta.dart';
class JobListSortItemRepository{
  List<String> getList(){
    return [
      "",
      "Top Rated",
      "Most Recent",
      "Mostly applied"
    ];
  }
}
class SortItem{
 String key;
 String value;

 SortItem({
   @required this.key,
   @required this.value,
 });

}
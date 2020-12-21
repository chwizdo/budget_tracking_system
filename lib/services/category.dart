import 'package:meta/meta.dart';

/*
  Add ✅
  Update ✅
  Delete
  View
*/

class Category {
  // private variable
  String _name;
  String _type;

  // constructor to create new category
  // all fields are mandatory
  Category({
    @required String name,
    @required String type,
  })  : _name = name,
        _type = type;

  // retrieve category name
  String get name {
    return _name;
  }

  // retrieve category type
  String get type {
    return _type;
  }

  // Update category properties
  void setProperties({String name, String type}) {
    _name = name;
    _type = type;
  }

  // TODO delete category
  void rmCategory() {}

  // TODO retrieve all categories in database
  static List<Category> getCategories() {}
}

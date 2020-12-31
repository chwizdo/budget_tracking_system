import 'dart:ffi';

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
  static List<Category> _list;

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

  static List<Category> get list {
    return _list;
  }

  // Update category properties
  void setProperties({String name, String type}) {
    _name = name;
    _type = type;
  }

  // TODO delete category
  void rmCategory() {}

  // TODO retrieve all categories in database
  // Temporary placeholder
  static void getCategories() {
    _list = [
      Category(name: 'food', type: 'expense'),
      Category(name: 'transport', type: 'expense'),
      Category(name: 'entertainment', type: 'expense'),
    ];
  }
}

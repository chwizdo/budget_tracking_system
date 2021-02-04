import 'dart:math';

import 'package:budget_tracking_system/services/record.dart' as service;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/*
  Add ✅
  Update ✅
  Delete
  View
*/

class Category {
  // private variable
  String _uid;
  String _id;
  String _name;
  String _type;
  List _colorStr = [];
  Color _color;
  static List<Category> _list = [];
  static List<Category> _incomeList = [];
  static List<Category> _expenseList = [];

  // constructor to create new category
  // all fields are mandatory
  Category({
    @required String uid,
    String id = '',
    @required String name,
    @required String type,
    List colorStr,
    bool save = false,
  })  : _uid = uid,
        _id = id,
        _name = name,
        _type = type,
        _colorStr = colorStr ?? [] {
    if (_colorStr.length == 0) {
      _colorStr.add(Random().nextInt(256));
      _colorStr.add(Random().nextInt(256));
      _colorStr.add(Random().nextInt(256));
    }
    _color = Color.fromRGBO(_colorStr[0], _colorStr[1], _colorStr[2], 1);
    if (save) {
      Firestore.instance
          .collection('users')
          .document(_uid)
          .collection('categories')
          .add(
        {
          'id': '',
          'name': _name,
          'type': _type,
          'color 1': _colorStr[0],
          'color 2': _colorStr[1],
          'color 3': _colorStr[2],
        },
      ).then(
        (value) => {
          _id = value.documentID,
          Firestore.instance
              .collection('users')
              .document(_uid)
              .collection('categories')
              .document(value.documentID)
              .updateData({'id': value.documentID})
        },
      );
    }
  }

  // retrieve category id
  String get id {
    return _id;
  }

  // retrieve category name
  String get name {
    return _name;
  }

  // retrieve category type
  String get type {
    return _type;
  }

  Color get color {
    return _color;
  }

  static List<Category> get list {
    return _list;
  }

  static List<Category> get incomeList {
    return _incomeList;
  }

  static List<Category> get expenseList {
    return _expenseList;
  }

  // Update category properties
  void setProperties({String name}) {
    _name = name;

    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('categories')
        .document(_id)
        .updateData({
      'name': _name,
    });
  }

  static List<Category> add(Category category) {
    _list.add(category);
    if (category._type == 'income') {
      _incomeList.add(category);
    } else {
      _expenseList.add(category);
    }
    return _list;
  }

  // TODO delete category
  void remove() {
    Category expense;
    Category income;

    // retrieve object of "No Category" in expense categories
    expense = getNoCat('expense');

    // retrieve object of "No Category" in income categories
    income = getNoCat('income');

    // delete category from list
    if (this._type == "income") {
      service.Record.list.forEach((service.Record record) {
        if (record.category == this) {
          record.category = income;
        }
      });
      _incomeList.remove(this);
    } else if (this._type == "expense") {
      service.Record.list.forEach((service.Record record) {
        if (record.category == this) {
          record.category = expense;
        }
      });
      _expenseList.remove(this);
    }
    _list.remove(this);

    // delete category in firebase
    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('categories')
        .document(_id)
        .delete();
  }

  // retrieve object of "No Category" in income or expense
  static Category getNoCat(String type) {
    Category returnCat;
    if (type == 'expense') {
      _expenseList.forEach((Category category) {
        if (category._name == "No Category") {
          returnCat = category;
        }
      });
    } else {
      _incomeList.forEach((Category category) {
        if (category._name == "No Category") {
          returnCat = category;
        }
      });
    }
    return returnCat;
  }

  // retrieve all categories in database
  static Future<void> getCategories({@required String uid}) async {
    _list = [];
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('categories')
        .getDocuments()
        .then((querySnapshot) => {
              querySnapshot.documents.forEach((element) {
                Category.add(
                  Category(
                    uid: uid,
                    id: element.data['id'],
                    name: element.data['name'],
                    type: element.data['type'],
                    colorStr: [
                      element.data['color 1'],
                      element.data['color 2'],
                      element.data['color 3']
                    ],
                  ),
                );
              }),
              print('Category retrieved: ${_list.length}'),
            });
    return null;
  }

  static Map<String, double> calIncomeTotal() {
    Map<String, double> incomeMap = new Map<String, double>();
    _incomeList.forEach((Category category) {
      double total = 0;
      service.Record.list.forEach((service.Record record) {
        if (record.category == category) {
          total += record.amount;
        }
      });
      incomeMap[category._name] = total;
    });
    return incomeMap;
  }

  static Map<String, double> calExpenseTotal() {
    Map<String, double> expenseMap = new Map<String, double>();
    _expenseList.forEach((Category category) {
      double total = 0;
      service.Record.list.forEach((service.Record record) {
        if (record.category == category) {
          total += record.amount;
        }
      });
      expenseMap[category._name] = total;
    });
    return expenseMap;
  }
}

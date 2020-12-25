import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
// import 'package:budget_tracking_system/services/account.dart';
// import 'package:budget_tracking_system/services/category.dart';
/*
  Add ✅
  Update ✅
  Delete
  View
*/

class Record {
  String _uid;
  String _type;
  String _title;
  DateTime _dateTime;
  String _category;
  String _account;
  double _amount;
  String _note;
  String _attachment;
  bool _isFav;

  // constructor to create new record
  // type, date & time, category and amount are mandatory
  Record({
    @required String uid,
    @required String type,
    String title = 'Untitled',
    @required DateTime dateTime,
    @required String category,
    @required String account,
    @required double amount,
    String note = '',
    String attachment = '',
    bool isFav = false,
  })  : _uid = uid,
        _type = type,
        _title = title,
        _dateTime = dateTime,
        _category = category,
        _account = account,
        _amount = amount,
        _note = note,
        _attachment = attachment,
        _isFav = isFav {
    //retrieve specfic user
    //var user = FirebaseAuth.instance.currentUser;
    //Firestore.instance.collection("users").document(user.toString()).get();
    //add
    Firestore.instance
        .collection("users")
        .document(_uid)
        .collection("record")
        .add({
      'type': _type,
      'title': _title,
      'datetime': _dateTime,
      'category': _category,
      'amount': _amount,
      'note': _note,
      'attachment': _attachment,
      'isFav': _isFav
    });
  }

  // getters for all private properties
  String get type {
    return _type;
  }

  String get title {
    return _title;
  }

  DateTime get dateTime {
    return _dateTime;
  }

  String get category {
    return _category;
  }

  String get account {
    return _account;
  }

  double get amount {
    return _amount;
  }

  String get note {
    return _note;
  }

  String get attachment {
    return _attachment;
  }

  bool get isFav {
    return _isFav;
  }

  // update all private properties
  // type, date & time, category and amount are mandatory
  void setProperties({
    @required String type,
    String title = 'Untitled',
    @required DateTime dateTime,
    @required String category,
    @required String account,
    @required double amount,
    String note,
    String attachment,
    bool isFav,
  }) {
    _type = type;
    _title = title;
    _dateTime = dateTime;
    _category = category;
    _account = account;
    _amount = amount;
    _note = note;
    _attachment = attachment;
    _isFav = isFav;
  }

  static List<Record> search() {}

  // TODO delete record
  // Implemented in main page
  void rmRecord() {}

  // TODO retrieve all records from database
  // Does not require to create instance
  // Implemented in main page
  static List<Record> getRecords() {}
}

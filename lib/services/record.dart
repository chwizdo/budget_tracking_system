import 'package:cloud_firestore/cloud_firestore.dart';
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
  static final List<Record> _list = [];

  // constructor to create new record
  // uid, type, date & time, category, account and amount are mandatory
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
    //add data to database
    Firestore.instance
        .collection("users")
        .document(_uid)
        .collection("record")
        .add({
      'id': '',
      'type': _type,
      'title': _title,
      'datetime': _dateTime,
      'category': _category, // TODO make it into a map
      'account': _account, // TODO make it into a map
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

  static List<Record> get list {
    return _list;
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
    String note = '',
    String attachment = '',
    bool isFav = false,
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

  static List<Record> add(Record record) {
    _list.add(record);
    return _list;
  }

  static List<Record> search({
    String type = '',
    String title = '',
    DateTime startDate,
    DateTime endDate,
    String category,
    String account,
    double leastAmount,
    double maxAmount,
    String note = '',
    bool attachment = false,
    // bool isFav,
  }) {
    List<Record> list = [];
    _list.forEach(
      (value) {
        // variables for validation
        var isMatch = 0;
        var hasValue = false;

        if (type.isNotEmpty) {
          hasValue = true;
          isMatch++;
          if (value.type == type) {
            isMatch--;
          }
        }

        if (title.isNotEmpty) {
          hasValue = true;
          isMatch++;
          if (value.title.toLowerCase().contains(title.toLowerCase())) {
            isMatch--;
          }
        }

        if (startDate != null) {
          hasValue = true;
          isMatch++;
          if (!value.dateTime.isBefore(startDate)) {
            isMatch--;
          }
        }

        if (endDate != null) {
          hasValue = true;
          isMatch++;
          if (!value.dateTime.isAfter(endDate)) {
            isMatch--;
          }
        }

        if (category != null) {
          hasValue = true;
          isMatch++;
          // TODO add .name on both sides
          // TODO change to category id
          if (value.category == category) {
            isMatch--;
          }
        }

        if (account != null) {
          hasValue = true;
          isMatch++;
          // TODO add .name on both sides
          // TODO change to account id
          if (value.account == account) {
            isMatch--;
          }
        }

        if (leastAmount != null) {
          hasValue = true;
          isMatch++;
          if (value.amount >= leastAmount) {
            isMatch--;
          }
        }

        if (maxAmount != null) {
          hasValue = true;
          isMatch++;
          if (value.amount <= maxAmount) {
            isMatch--;
          }
        }

        if (note.isNotEmpty) {
          hasValue = true;
          isMatch++;
          if (value.note.toLowerCase().contains(note.toLowerCase())) {
            isMatch--;
          }
        }

        if (attachment == true) {
          hasValue = true;
          isMatch++;
          if (value.attachment.isNotEmpty) {
            isMatch--;
          }
        }

        // if isMatch is more than 1, there are some field that does not match
        // if hasValue is false, none of the if statements evaluates to true, means that no valued arguments are passed
        if (isMatch == 0 && hasValue) {
          list.add(value);
        }
      },
    );
    // return the list of records that matched the criteria
    return list;
  }

  // TODO delete record
  // Implemented in main page
  void rmRecord() {}

  // TODO retrieve all records from database
  // Does not require to create instance
  // Implemented in main page
  static List<Record> getRecords() {}
}

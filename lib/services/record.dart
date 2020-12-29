import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:budget_tracking_system/services/account.dart';
import 'package:budget_tracking_system/services/category.dart';
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
  Category _category;
  Account _account;
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
    @required Category category,
    @required Account account,
    @required double amount,
    String note = '',
    String attachment = '',
    bool isFav = false,
    bool save = true,
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
    if (save) {
      Firestore.instance
          .collection('users')
          .document(_uid)
          .collection('records')
          .add(
        {
          'id': '',
          'type': _type,
          'title': _title,
          'date time': _dateTime,
          'category': _category.name, // TODO use id
          'account': _account.name, // TODO use id
          'amount': _amount,
          'note': _note,
          'attachment': _attachment,
          'is favorite': _isFav,
        },
      ).then(
        (value) => {
          Firestore.instance
              .collection('users')
              .document(_uid)
              .collection('records')
              .document(value.documentID)
              .updateData({'id': value.documentID})
        },
      );
    }
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

  Category get category {
    return _category;
  }

  Account get account {
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
    @required Category category,
    @required Account account,
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

  // Does not require to create instance
  // Implemented in main page
  static void getRecords({String uid}) {
    Firestore.instance
        .collection('users')
        .document(uid)
        .collection('records')
        .getDocuments()
        .then(
          (querySnapshot) => {
            querySnapshot.documents.forEach(
              (element) {
                Timestamp timestamp = element.data['date time'];
                Category category;
                Category.list.forEach((cat) {
                  if (cat.name == element.data['category']) {
                    category = cat;
                  }
                });
                Account account;
                Account.list.forEach((acc) {
                  if (acc.name == element.data['account']) {
                    account = acc;
                  }
                });
                Record.add(Record(
                  uid: uid,
                  type: element.data['type'],
                  title: element.data['title'],
                  dateTime: DateTime.fromMicrosecondsSinceEpoch(
                      timestamp.seconds * 1000),
                  category: category,
                  account: account,
                  amount: element.data['amount'],
                  note: element.data['note'],
                  attachment: element.data['attachment'],
                  isFav: element.data['is favorite'],
                  save: false,
                ));
              },
            ),
            print('Record retrieved: $_list')
          },
        );
  }
}

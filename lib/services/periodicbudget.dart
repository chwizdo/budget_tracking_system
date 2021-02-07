import 'package:budget_tracking_system/services/record.dart';
import 'package:budget_tracking_system/services/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class PeriodicBudget {
  String _uid;
  String _id;
  String _title;
  String _interval;
  Category _category;
  double _amount;
  double _amountUsed;
  static List<PeriodicBudget> _list = [];
  DateTime _startDate;
  static List<PeriodicBudget> _activeList = [];

  // Constructor for Add Budget
  // interval (refresh), onetime (change state)
  // method-refresh when start app
  PeriodicBudget({
    @required String uid,
    String id = " ",
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
    @required DateTime startDate,
    bool save = false,
  })  : _title = title,
        _uid = uid,
        _id = id,
        _category = category,
        _amount = amount,
        _interval = interval,
        _startDate = startDate {
    if (save == true) {
      Firestore.instance
          .collection("users")
          .document(_uid)
          .collection("periodic budget")
          .add({
        "id": " ",
        "title": _title,
        "interval": _interval,
        "category": _category.id,
        "amount": _amount,
        "amount used": 0,
        "start date": _startDate,
      }).then((value) => {
                _id = value.documentID,
                Firestore.instance
                    .collection("users")
                    .document(_uid)
                    .collection("periodic budget")
                    .document(value.documentID)
                    .updateData({'id': value.documentID})
              });
    }
  }

  // getter for each properties
  String get id {
    return _id;
  }

  String get title {
    return _title;
  }

  Category get category {
    return _category;
  }

  double get amount {
    return _amount;
  }

  double get amountUsed {
    return _amountUsed;
  }

  String get interval {
    return _interval;
  }

  static List<PeriodicBudget> get list {
    return _list;
  }

  DateTime get startDate {
    return _startDate;
  }

  static List<PeriodicBudget> get activeList {
    return _activeList;
  }

  // setter/update budget
  void setBudget({
    @required String title,
    @required Category category,
    @required double amount,
    @required String interval,
    @required DateTime startDate,
  }) {
    _title = title;
    _category = category;
    _amount = amount;
    _interval = interval;
    _startDate = startDate;

    Firestore.instance
        .collection("users")
        .document(_uid)
        .collection("periodic budget")
        .document(_id)
        .updateData({
      "title": _title,
      "category": _category.id,
      "amount": _amount,
      "interval": _interval,
      "start date": _startDate
    });
  }

  // Add all periodic budget into _list
  static List<PeriodicBudget> add(PeriodicBudget periodicBudget) {
    _list.add(periodicBudget);
    return _list;
  }

  // Delete budget based on list index
  void delete() {
    Record.list.forEach((element) {
      if (element.budget == this) {
        element.budget = null;
      }
    });
    _list.remove(this);

    Firestore.instance
        .collection("users")
        .document(_uid)
        .collection("periodic budget")
        .document(_id)
        .delete();
  }

  // calculate amountUsed (Weekly cannot do)
  // take all record for that period of time
  static void calculateAmountUsed() {
    _list.forEach((periodicbudget) {
      double sum = 0;
      double sum2 = 0;
      if (periodicbudget._interval == "Monthly") {
        List<Record> monthlyRecordList = [];
        Record.list.forEach((record) {
          if (record.budget == periodicbudget &&
              record.dateTime.month == DateTime.now().month &&
              record.dateTime.year == DateTime.now().year) {
            monthlyRecordList.add(record);
          }
        });
        monthlyRecordList.forEach((element) {
          sum += element.amount;
        });
        periodicbudget._amountUsed = sum;
      } else if (periodicbudget._interval == "Weekly") {
        List<Record> weeklyRecordList = [];
        Record.list.forEach((record) {
          if (record.budget == periodicbudget &&
              record.dateTime.month == DateTime.now().month &&
              record.dateTime.year == DateTime.now().year) {
            weeklyRecordList.add(record);
          }
        });
        weeklyRecordList.forEach((element) {
          sum2 += element.amount;
        });
        periodicbudget._amountUsed = sum2;
      }
      Firestore.instance
          .collection("users")
          .document(periodicbudget._uid)
          .collection("periodic budget")
          .document(periodicbudget._id)
          .updateData({"amount used": periodicbudget._amountUsed});
    });
  }

  // return active budget list based on a datetime
  // static List<PeriodicBudget> returnList(DateTime dateTime) {
  //   _activeList = [];
  //   _list.forEach((element) {
  //     if (!element.startDate.isAfter(dateTime)) {
  //       _activeList.add(element);
  //     } else if (element.startDate.month == dateTime.month &&
  //         element.startDate.year == dateTime.year) {
  //       _activeList.add(element);
  //     }
  //   });
  //   return _activeList;
  // }

  // return active budget list based on a datetime
  static List<PeriodicBudget> returnList(DateTime dateTime, Category category) {
    _activeList = [];
    _list.forEach((element) {
      if (!element.startDate.isAfter(dateTime) &&
          element.category == category) {
        _activeList.add(element);
      } else if (element.startDate.month == dateTime.month &&
          element.startDate.year == dateTime.year &&
          element.category == category) {
        _activeList.add(element);
      }
    });
    return _activeList;
  }

  static Future<void> getPeriodicBudget({@required String uid}) async {
    _list = [];
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('periodic budget')
        .getDocuments()
        .then(
          (querySnapshot) => {
            querySnapshot.documents.forEach(
              (element) {
                Timestamp timestamp = element.data['start date'];
                Category category;
                Category.list.forEach((cat) {
                  if (cat.id == element.data['category']) {
                    category = cat;
                  }
                });
                PeriodicBudget.add(PeriodicBudget(
                  uid: uid,
                  id: element.data['id'],
                  title: element.data['title'],
                  startDate: DateTime.fromMicrosecondsSinceEpoch(
                      timestamp.microsecondsSinceEpoch),
                  category: category,
                  interval: element.data['interval'],
                  amount: element.data['amount'],
                  save: false,
                ));
              },
            ),
            print('Periodic Budget retrieved: ${_list.length}')
          },
        );
    return null;
  }

  static List findEachMonthAmount(PeriodicBudget budget) {
    List<double> eachmonth = [];
    for (int i = 1; i < 13; i++) {
      double sum = 0;
      List<Record> r = [];
      Record.list.forEach((record) {
        if (record.budget == budget && record.dateTime.month == i) {
          r.add(record);
        }
      });
      r.forEach((element) {
        sum += element.amount;
      });
      eachmonth.add(sum);
    }
    return eachmonth;
  }

  static List findEachDayAmount(PeriodicBudget budget, DateTime month) {
    List<double> eachday = [];
    for (int i = 1; i < 31; i++) {
      double sum = 0;
      List<Record> r = [];
      Record.list.forEach((record) {
        if (record.budget == budget &&
            record.dateTime.day == i &&
            record.dateTime.month == month.month &&
            record.dateTime.year == month.year) {
          r.add(record);
        }
      });
      r.forEach((element) {
        sum += element.amount;
      });
      eachday.add(sum);
    }
    return eachday;
  }
}

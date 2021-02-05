import 'dart:math';

import 'package:budget_tracking_system/pages/budgetperiodic.dart';
import 'package:budget_tracking_system/services/currency.dart';
import 'package:budget_tracking_system/services/onetimebudget.dart';
import 'package:budget_tracking_system/services/periodicbudget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String _id;
  String _type;
  String _title;
  DateTime _dateTime;
  Category _category;
  Account _account;
  Account _toAccount;
  dynamic _budget;
  double _amount;
  String _note;
  String _attachment;
  bool _isFav;
  static List<Record> _list = [];

  // constructor to create new record
  // uid, type, date & time, category, account and amount are mandatory
  // the id parameter must NOT be used
  Record({
    @required String uid,
    String id = '',
    @required String type,
    String title = 'Untitled',
    @required DateTime dateTime,
    Category category,
    @required Account account,
    Account toAccount,
    dynamic budget,
    @required double amount,
    String note = '',
    String attachment = '',
    bool isFav = false,
    bool save = false,
  })  : _uid = uid,
        _id = id,
        _type = type,
        _title = title,
        _dateTime = dateTime,
        _category = category,
        _account = account,
        _toAccount = toAccount,
        _budget = budget,
        _amount = amount,
        _note = note,
        _attachment = attachment,
        _isFav = isFav {
    if (_type == 'Transfer' && save) {
      double newCurrAmount = _amount;
      if (_account.currency != _toAccount.currency) {
        newCurrAmount = Currency.convertCurrency(
            base: _account.currency,
            target: _toAccount.currency,
            value: _amount);
      }
      toAccount.setProperties(
          name: toAccount.name, amount: toAccount.amount + newCurrAmount);
      account.setProperties(
          name: account.name, amount: account.amount - _amount);
    } else if (_type == 'Income' && save) {
      account.setProperties(
          name: account.name, amount: account.amount + _amount);
    } else if (_type == 'Expenses' && save) {
      account.setProperties(
          name: account.name, amount: account.amount - _amount);
    }

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
          'category': _category != null ? _category.id : null,
          'account': _account.id,
          'To Account': _toAccount != null ? _toAccount.id : null,
          'budget': _budget != null ? _budget.id : null,
          'amount': _amount,
          'note': _note,
          'attachment': _attachment,
          'is favorite': _isFav,
        },
      ).then(
        (value) => {
          _id = value.documentID,
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
  String get id {
    return _id;
  }

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

  dynamic get budget {
    return _budget;
  }

  set category(Category category) {
    _category = category;

    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('records')
        .document(_id)
        .updateData({'category': _category.id});
  }

  Account get account {
    return _account;
  }

  Account get toAccount {
    return _toAccount;
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
    Category category,
    @required Account account,
    Account toAccount,
    dynamic budget,
    @required double amount,
    String note = '',
    String attachment = '',
    bool isFav = false,
  }) {
    // to remember account and amount information before edit
    Account oldFromAccount = _account;
    Account oldToAccount = _toAccount;
    double oldFromAmount = _amount;
    double oldToAmount;
    if (oldToAccount != null) {
      oldToAmount = Currency.convertCurrency(
          base: oldFromAccount.currency,
          target: oldToAccount.currency,
          value: oldFromAmount);
    }

    _type = type;
    _title = title;
    _dateTime = dateTime;
    _category = category;
    _account = account;
    _toAccount = toAccount;
    _amount = amount;
    _budget = budget;
    _note = note;
    _attachment = attachment;
    _isFav = isFav;

    if (_type == 'Transfer') {
      // convert amount to new currency
      double convertedToAmount = _amount;
      convertedToAmount = Currency.convertCurrency(
          base: _account.currency, target: _toAccount.currency, value: _amount);

      if (oldFromAccount == _account && oldToAccount == _toAccount) {
        // if user doesn't select different from or to account
        _account.setProperties(
            name: _account.name,
            amount: _account.amount - (_amount - oldFromAmount));
        _toAccount.setProperties(
            name: _toAccount.name,
            amount: _toAccount.amount + (convertedToAmount - oldToAmount));
      } else if (oldFromAccount == _account && oldToAccount != _toAccount) {
        // if user select different to account
        _account.setProperties(
            name: _account.name,
            amount: _account.amount - (_amount - oldFromAmount));
        oldToAccount.setProperties(
            name: oldToAccount.name, amount: oldToAccount.amount - oldToAmount);
        _toAccount.setProperties(
            name: _toAccount.name,
            amount: _toAccount.amount + convertedToAmount);
      } else if (oldFromAccount != _account && oldToAccount == _toAccount) {
        // If user select different from account
        oldFromAccount.setProperties(
            name: oldFromAccount.name,
            amount: oldFromAccount.amount + oldFromAmount);
        _account.setProperties(
            name: _account.name, amount: _account.amount - oldFromAmount);
        _toAccount.setProperties(
            name: _toAccount.name,
            amount: _toAccount.amount + (convertedToAmount - oldToAmount));
      } else {
        // if user select different account for both from and to
        oldFromAccount.setProperties(
            name: oldFromAccount.name,
            amount: oldFromAccount.amount + oldFromAmount);
        _account.setProperties(
            name: _account.name, amount: _account.amount - oldFromAmount);
        oldToAccount.setProperties(
            name: oldToAccount.name, amount: oldToAccount.amount - oldToAmount);
        _toAccount.setProperties(
            name: _toAccount.name,
            amount: _toAccount.amount + convertedToAmount);
      }
    } else if (_type == 'Income') {
      _toAccount = null;
      account.setProperties(
          name: account.name,
          amount: account.amount + (_amount - oldFromAmount));
    } else if (_type == 'Expenses') {
      _toAccount = null;
      account.setProperties(
          name: account.name,
          amount: account.amount - (_amount - oldFromAmount));
    }

    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('records')
        .document(_id)
        .updateData({
      'type': _type,
      'title': _title,
      'date time': _dateTime,
      'category': _category != null ? _category.id : null,
      'account': _account.id,
      'To Account': _toAccount != null ? _toAccount.id : null,
      'budget': _budget != null ? _budget.id : null,
      'amount': _amount,
      'note': _note,
      'attachment': _attachment,
      'is favorite': _isFav,
    });
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
    print(account);
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

        if (category != null && value._category != null) {
          hasValue = true;
          isMatch++;
          // TODO add .name on both sides
          // TODO change to category id
          if (value._category.name == category) {
            isMatch--;
          }
        }

        if (account != null) {
          hasValue = true;
          isMatch++;
          // TODO add .name on both sides
          // TODO change to account id
          if (value.account.name == account) {
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
  void remove() {
    if (_type == 'Transfer') {
      double newCurrAmount = _amount;
      if (_account.currency != _toAccount.currency) {
        newCurrAmount = Currency.convertCurrency(
            base: _account.currency,
            target: _toAccount.currency,
            value: _amount);
      }
      toAccount.setProperties(
          name: toAccount.name, amount: toAccount.amount - newCurrAmount);
      account.setProperties(
          name: account.name, amount: account.amount + _amount);
    } else if (_type == 'Income') {
      account.setProperties(
          name: account.name, amount: account.amount - _amount);
    } else if (_type == 'Expenses') {
      account.setProperties(
          name: account.name, amount: account.amount + _amount);
    }

    _list.remove(this);

    // delete category in firebase
    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('records')
        .document(_id)
        .delete();
  }

  // Does not require to create instance
  // Implemented in main page
  static Future<void> getRecords({@required String uid}) async {
    _list = [];
    await Firestore.instance
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
                  if (cat.id == element.data['category']) {
                    category = cat;
                  }
                });
                Account account;
                Account.list.forEach((acc) {
                  if (acc.id == element.data['account']) {
                    account = acc;
                  }
                });
                Account toAccount;
                Account.list.forEach((acc) {
                  if (acc.id == element.data['To Account']) {
                    toAccount = acc;
                  }
                });
                dynamic budget;
                List<dynamic> budgetList = [];
                PeriodicBudget.returnList(DateTime.fromMicrosecondsSinceEpoch(
                        timestamp.microsecondsSinceEpoch))
                    .forEach((PeriodicBudget budget) {
                  budgetList.add(budget);
                });
                OneTimeBudget.returnList(DateTime.fromMicrosecondsSinceEpoch(
                        timestamp.microsecondsSinceEpoch))
                    .forEach((OneTimeBudget budget) {
                  budgetList.add(budget);
                });
                budgetList.forEach((bud) {
                  if (bud.id == element.data['budget']) {
                    budget = bud;
                  }
                });
                Record.add(Record(
                  uid: uid,
                  id: element.data['id'],
                  type: element.data['type'],
                  title: element.data['title'],
                  dateTime: DateTime.fromMicrosecondsSinceEpoch(
                      timestamp.microsecondsSinceEpoch),
                  category: category,
                  account: account,
                  toAccount: toAccount,
                  budget: budget,
                  amount: element.data['amount'],
                  note: element.data['note'],
                  attachment: element.data['attachment'],
                  isFav: element.data['is favorite'],
                  save: false,
                ));
              },
            ),
            print('Record retrieved: ${_list.length}')
          },
        );
    return null;
  }

  static List calculate({String currency}) {
    double totalIncome = 0;
    double totalExpense = 0;
    _list.forEach((Record record) {
      if (record._account.currency == currency) {
        if (record._type == 'Income') {
          totalIncome += record._amount;
        } else if (record._type == 'Expenses') {
          totalExpense += record._amount;
        }
      }
    });
    double balance = totalIncome - totalExpense;
    print(totalIncome);
    return [totalIncome, totalExpense, balance];
  }
}

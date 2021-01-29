import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

/*
  Add ✅
  Update
  Calculation ✅
  Delete
  View
*/

class Account {
  String _uid;
  String _id;
  String _name;
  final _currency;

  double _amount;

  static List<Account> _list = [];

  // constructor to create new account
  Account({
    @required String uid,
    String id = '',
    @required String name,
    @required String currency,
    double amount = 0,
    DateTime dateTime,
    bool save = false,
  })  : _uid = uid,
        _id = id,
        _name = name,
        _currency = currency,
        _amount = amount {
    if (save) {
      Firestore.instance
          .collection('users')
          .document(_uid)
          .collection('accounts')
          .add({
        'id': '',
        'name': _name,
        'currency': _currency,
        'amount': _amount,
      }).then((value) => {
                _id = value.documentID,
                Firestore.instance
                    .collection('users')
                    .document(_uid)
                    .collection('accounts')
                    .document(value.documentID)
                    .updateData({'id': value.documentID})
              });
    }
  }

  // add or reduce amount in account
  // return amount after modification
  double modAmount({double amount}) {
    _amount += amount;
    return _amount;
  }

  // retrieve account id
  String get id {
    return _id;
  }

  // retrieve account name
  String get name {
    return _name;
  }

  // retrieve account currency
  String get currency {
    return _currency;
  }

  // retrieve account amount
  double get amount {
    return _amount;
  }

  static List<Account> get list {
    return _list;
  }

  // Update account properties
  // user are not allowed to change currency
  // TODO return difference in amount (Need to add new record for settings changes)
  double setProperties({
    @required String name,
    double amount = 0,
  }) {
    var difference = amount - _amount;
    _name = name;
    _amount = amount;
    Firestore.instance
        .collection('users')
        .document(_uid)
        .collection('accounts')
        .document(_id)
        .updateData({
      'name': _name,
      'amount': _amount,
    });
    return difference;
  }

  static List<Account> add(Account account) {
    _list.add(account);
    return _list;
  }

  // TODO delete account
  void rmAccount() {}

  // TODO retrieve all accounts in database
  static Future<void> getAccounts({@required String uid}) async {
    _list = [];
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('accounts')
        .getDocuments()
        .then((querySnapshot) => {
              querySnapshot.documents.forEach((element) {
                _list.add(Account(
                  uid: uid,
                  name: element.data['name'],
                  currency: element.data['currency'],
                  amount: element.data['amount'],
                  //dateTime: element.data['dateTime'],
                ));
              }),
              print('Account retrieved: ${_list[3]._name}'),
              print(_list[3]._amount)
            });
  }
}

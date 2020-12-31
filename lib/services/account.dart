import 'package:meta/meta.dart';

/*
  Add ✅
  Update
  Calculation ✅
  Delete
  View
*/

class Account {
  String _name;
  final _currency;
  double _amount;
  static List<Account> _list;

  // constructor to create new account
  Account({
    @required String name,
    @required String currency,
    double amount = 0,
  })  : _name = name,
        _currency = currency,
        _amount = amount;

  // add or reduce amount in account
  // return amount after modification
  double modAmount({double amount}) {
    _amount += amount;
    return _amount;
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
    return difference;
  }

  // TODO delete account
  void rmAccount() {}

  // TODO retrieve all accounts in database
  static void getAccounts() {
    _list = [
      Account(name: 'cash', currency: 'MYR', amount: 500),
      Account(name: 'maybank', currency: 'MYR', amount: 500),
      Account(name: 'card', currency: 'MYR', amount: 500),
    ];
  }
}

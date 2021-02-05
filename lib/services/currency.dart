import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class Currency {
  // private properties
  static final _accessKey = '6f64709d2060a5354bc6c63122b26884';
  static final _apiEndpoint = 'latest';
  static var _jsonResponse;
  static var _main = 'USD';
  static List<Currency> _fullList = [];
  static List<Currency> _list = [];

  String _uid;
  String _id;
  String _name;
  bool isChecked;

  Currency({
    String id = '',
    String uid,
    @required String name,
    @required bool isChecked,
  }) {
    _uid = uid;
    _id = id;
    _name = name;
    this.isChecked = isChecked;
  }

  String get name {
    return _name;
  }

  String get uid {
    return _uid;
  }

  String get id {
    return _id;
  }

  static void add(
      {Currency currency, @required String uid, String id, bool save = false}) {
    currency._uid = uid;
    currency._id = id ?? '';
    currency.isChecked = true;
    _list.add(currency);

    if (save) {
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('currencies')
          .add({
        'id': '',
        'name': currency._name,
        'is checked': currency.isChecked,
      }).then((querySnapshot) {
        Firestore.instance
            .collection('users')
            .document(uid)
            .collection('currencies')
            .document(querySnapshot.documentID)
            .updateData({
          'id': querySnapshot.documentID,
        });
        currency._id = querySnapshot.documentID;
      });
    }
  }

  static double getCurrencyRate({Currency currency}) {
    return _jsonResponse['rates'][currency._name];
  }

  static void setCurrencyRate({Currency currency, double rate}) {
    _jsonResponse['rates'][currency._name] = rate;
  }

  static void remove({Currency currency, @required String uid}) {
    currency.isChecked = false;

    Firestore.instance
        .collection('users')
        .document(uid)
        .collection('currencies')
        .document(currency._id)
        .delete();

    _list.remove(currency);
  }

  // initialize API connection and refresh connection every 1 hour
  // can only RUN ONCE
  static Future<dynamic> init({String uid}) async {
    _jsonResponse = await _conn();
    print('API connection established');
    _fullList = [];
    _jsonResponse['rates'].forEach((key, value) {
      _fullList.add(Currency(name: key, isChecked: false));
    });
    Timer.periodic(Duration(hours: 1), (timer) async {
      _jsonResponse = await _conn();
      print('API connection refreshed');
      _fullList = [];
      _jsonResponse['rates'].forEach((key, value) {
        _fullList = [];
        _fullList.add(Currency(name: key, isChecked: false));
      });
    });

    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('currencies')
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((element) {
        _fullList.forEach((Currency currency) {
          if (currency.name == element.data['name']) {
            add(currency: currency, uid: uid, id: element.data['id']);
          }
        });
      });
    });

    print('Currencies retrieved: ${_list.length}');
  }

  // establish connection towards Fixer.io
  // return json file if successed, null if failed
  static Future<dynamic> _conn() async {
    try {
      var response = await get(
          'http://data.fixer.io/api/$_apiEndpoint?access_key=$_accessKey');
      return jsonDecode(response.body);
    } catch (e) {
      print('Problem occured while initializing connection to API');
      print('Error message: $e');
      return null;
    }
  }

  // obtain current main currency
  static String get main {
    return _main;
  }

  // obtain current sub currencies with currency rate relative to main currency
  static List<Currency> get list {
    return _list;
  }

  static List get fullList {
    return List.from(_fullList);
  }

  // convert base currency to target currency based on base value
  static double convertCurrency({String base, String target, double value}) {
    var toEurConversion = _jsonResponse['rates'][base];
    var fromEurConversion = _jsonResponse['rates'][target];

    if (base == 'EUR' && target != 'EUR') {
      return double.parse((value * fromEurConversion).toStringAsFixed(2));
    } else if (base != 'EUR' && target != 'EUR') {
      return double.parse(
          ((value / toEurConversion) * fromEurConversion).toStringAsFixed(2));
    } else if (base != 'EUR' && target == 'EUR') {
      return double.parse((value / toEurConversion).toStringAsFixed(2));
    } else {
      return value;
    }
  }

  // get currency rete of base currency to target currency
  static double getRate({String base, String target}) {
    var toEurConversion = _jsonResponse['rates'][base];
    var fromEurConversion = _jsonResponse['rates'][target];

    if (base == 'EUR' && target != 'EUR') {
      return fromEurConversion;
    } else if (base != 'EUR' && target != 'EUR') {
      return (1 / toEurConversion * fromEurConversion);
    } else if (base != 'EUR' && target == 'EUR') {
      return (1 / toEurConversion);
    } else {
      return 1;
    }
  }
}

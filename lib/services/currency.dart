import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class Currency {
  // private properties
  static final _accessKey = '6f64709d2060a5354bc6c63122b26884';
  static final _apiEndpoint = 'latest';
  static var _jsonResponse;
  static var _main = 'USD';
  static final _fullMap = <String, double>{};
  static var _fullList = [];
  static final _list = <String, double>{};

  // initialize API connection and refresh connection every 1 hour
  // can only RUN ONCE
  static Future<dynamic> init() async {
    _jsonResponse = await _conn();
    print('API connection established');
    _fullList = [];
    _jsonResponse['rates'].forEach((key, value) {
      _fullMap[key] = getRate(base: _main, target: key);
      _fullList.add(key);
    });
    Timer.periodic(Duration(hours: 1), (timer) async {
      _jsonResponse = await _conn();
      print('API connection refreshed');
      _fullList = [];
      _jsonResponse['rates'].forEach((key, value) {
        _fullMap[key] = getRate(base: _main, target: key);
        _fullList.add(key);
      });
      _refreshRate();
    });
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

  // update main currency
  static set main(String newMain) {
    _main = newMain;
    _refreshRate();
  }

  // obtain current main currency
  static String get main {
    return _main;
  }

  // add sub currency
  static Map<String, double> addSub({String currency}) {
    _list[currency] = getRate(base: _main, target: currency);
    return _list;
  }

  // remove sub currency
  static Map<String, double> rmSub({String currency}) {
    _list.remove(currency);
    return _list;
  }

  // obtain current sub currencies with currency rate relative to main currency
  static Map<String, double> get list {
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

  // Update the currency rates of all sub currencies
  static void _refreshRate() {
    _list.forEach((key, value) {
      _list[key] = getRate(base: _main, target: key);
    });
  }
}

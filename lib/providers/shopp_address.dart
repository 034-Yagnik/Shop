import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ShoppAddress with ChangeNotifier {
  final String id;
  final String name;
  final double mobilenumber;
  final double pincode;
  final String address;
  final String city;
  final String state;

  ShoppAddress({
    @required this.id,
    @required this.name,
    @required this.mobilenumber,
    @required this.pincode,
    @required this.address,
    @required this.city,
    @required this.state,
  });

  Future<void> addaddress(ShoppAddress shoppAddress) async {
    final url = 'https://shop-app-5fd1b.firebaseio.com/shoppAddress.json';
    try {
      await http.post(
        url,
        body: json.encode({
          'name': shoppAddress.name,
          'mobilenumber': shoppAddress.mobilenumber,
          'pincode': shoppAddress.pincode,
          'address': shoppAddress.address,
          'city': shoppAddress.city,
          'state': shoppAddress.state,
        }),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

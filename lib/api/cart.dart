// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pwa/model/carts.dart';

Future<Cart?> fetchCarts() async {
  var url = Uri.parse('https://dummyjson.com/cart/1');
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La requête a réussi, vous pouvez traiter les données ici
      Cart data = Cart.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      // La requête a échoué
      if (kDebugMode) {
        print(
            'Échec de la requête avec le code d\'état : ${response.statusCode}');
      }
      return null;
    }
  } catch (_) {
    return null;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pwa/model/user.dart';

Future<User?> fetchUser() async {
  var url = Uri.parse('https://dummyjson.com/users/1');
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // La requête a réussi, vous pouvez traiter les données ici
      User data = User.fromJson(jsonDecode(response.body));
      print(data);
      return data;
    } else {
      // La requête a échoué
      print(
          'Échec de la requête avec le code d\'état : ${response.statusCode}');
      return null;
    }
  } catch (_) {
    return null;
  }
}

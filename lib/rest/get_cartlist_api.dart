import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:varchandise/models/cart_models.dart';

//GET HISTORY
Future<List<Cart>> getAllUserCart(String userID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/allUserCart'),
      headers: {"Accept": "Application/json"}, body: {'userID': userID});
  var decodedData = jsonDecode(response.body);
  print(decodedData);
  List<Cart> list = [];
  for (var i in decodedData) {
    Cart fetchedData = Cart.fromJson(i);
    list.add(fetchedData);
  }

  return list;
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//GET PRODUCT FROM HISTORY
Future getSpecificProduct(String productID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
      Uri.parse('$baseUrl/users/get-product?id=$productID'),
      headers: {"Accept": "Application/json"});
  var decodedData = jsonDecode(response.body);
  print(decodedData);
  return decodedData;
}

DateTime decomposeDate(String date) {
  var newDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
  return newDate;
}

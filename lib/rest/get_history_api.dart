import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:varchandise/models/history_models.dart';

//GET HISTORY
Future<List<History>> getUserHistory(String userID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/AllUserHistory'),
      headers: {"Accept": "Application/json"}, body: {'userID': userID});
  var decodedData = jsonDecode(response.body);
  print(decodedData);
  List<History> list = [];
  for (var i in decodedData) {
    History fetchedData = History.fromJson(i);
    list.add(fetchedData);
  }

  return list;
}

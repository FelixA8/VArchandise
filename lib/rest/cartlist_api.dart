import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:varchandise/models/cart_models.dart';

//GET CART
Future<List<Cart>> getAllUserCart(String userID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/allUserCart'),
      headers: {"Accept": "Application/json"}, body: {'userID': userID});
  var decodedData = jsonDecode(response.body);
  List<Cart> list = [];
  for (var i in decodedData) {
    Cart fetchedData = Cart.fromJson(i);
    list.add(fetchedData);
  }

  return list;
}

//GET CART HIGHEST ID
Future getCartID() async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
    Uri.parse('$baseUrl/users/getCartHighestID'),
    headers: {"Accept": "Application/json"},
  );
  var decodedData = jsonDecode(response.body.toString());
  return decodedData;
}

//GET HIGHEST ID NUMBER
int extractAndIncrement(String input) {
  RegExp regex = RegExp(r'\d+');
  Match match = regex.firstMatch(input) as Match;
  String? numbersOnly = match.group(0);

  int currentNumber = int.parse(numbersOnly!);
  int incrementedNumber = currentNumber + 1;

  return incrementedNumber;
}

//CREATE A NEW CART
Future<bool> createNewUserCart(
    String userID, String productID, int cartAmount, bool isSelected) async {
  String isSelect = "";
  var id = "";
  if (isSelected == true) {
    isSelect = "true";
  } else {
    isSelect = "false";
  }
  var data = await getCartID();
  if (data.length == 0) {
    id = 'CA001';
  } else {
    var newID = data[0]["CartID"];
    int inputID = extractAndIncrement(newID);
    id = 'CA${inputID.toString().padLeft(3, '0')}';
  }
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http
      .post(Uri.parse('$baseUrl/users/insert-new-user-carts'), headers: {
    "Accept": "Application/json"
  }, body: {
    'cartID': id,
    'userID': userID,
    'productID': productID,
    'cartAmount': cartAmount.toString(),
    'isSelected': isSelect
  });
  var decodedData = jsonDecode(response.body);

  return decodedData["success"];
}

//UPDATE ANY USER CART
Future<bool> updateNewUserCart(
    String cartID, String userID, int cartAmount, bool isSelected) async {
  String isSelect = "";
  if (isSelected == true) {
    isSelect = "true";
  } else {
    isSelect = "false";
  }
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http
      .post(Uri.parse('$baseUrl/users/update-new-user-cart'), headers: {
    "Accept": "Application/json"
  }, body: {
    'cartID': cartID,
    'userID': userID,
    'cartAmount': cartAmount.toString(),
    'isSelected': isSelect
  });
  var decodedData = jsonDecode(response.body);

  return decodedData["success"];
}

//DELETE USER CART
Future<bool> deleteUserCart(String cartID, String userID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response =
      await http.delete(Uri.parse('$baseUrl/users/delete-user-cart'), headers: {
    "Accept": "Application/json"
  }, body: {
    'cartID': cartID,
    'userID': userID,
  });
  var decodedData = jsonDecode(response.body);

  return decodedData["success"];
}

Future<String> getTotalCartPrice(String userID) async {
  String total = "";
  String totalFormatted = "";
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/SumAllCartPrice'),
      headers: {"Accept": "Application/json"}, body: {"userID": userID});
  var decodedData = jsonDecode(response.body);
  if (decodedData["TotalPrice"] != null) {
    total = decodedData["TotalPrice"];
    totalFormatted = getFormattedTotalPrice(int.parse(total));
  }

  return totalFormatted;
}

//UPDATE PRODUCT STOCK
Future<bool> updateProductStock(String cartID, int cartAmount) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http
      .post(Uri.parse('$baseUrl/users/update-product-stock'), headers: {
    "Accept": "Application/json"
  }, body: {
    'productID': cartID,
    'cartAmount': cartAmount.toString(),
  });
  var decodedData = jsonDecode(response.body);

  return decodedData["success"];
}

String getFormattedTotalPrice(int totalPrice) {
  return NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
      .format(totalPrice);
}

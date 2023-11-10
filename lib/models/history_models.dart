import 'package:intl/intl.dart';
import 'package:varchandise/models/cart_models.dart';

class History {
  History({
    required this.historyID,
    required this.customerID,
    required this.productID,
    required this.purchasedAmount,
    required this.totalPrice,
    required this.datePurchased,
  });
  String historyID;
  String productID;
  String customerID;
  Category purchasedAmount;
  int totalPrice;
  String datePurchased;

  String get getFormattedTotalPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(totalPrice);
  }
}

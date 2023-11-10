import 'package:intl/intl.dart';
import 'package:varchandise/models/cart_models.dart';

class Product {
  Product(
      {required this.productCategory,
      required this.productDescription,
      required this.productID,
      required this.productImageURL,
      required this.productName,
      required this.productPrice,
      required this.productSeller,
      required this.productStock});
  String productID;
  String productName;
  String productDescription;
  Category productCategory;
  int productStock;
  String productImageURL;
  String productSeller;
  int productPrice;

  String get getFormattedPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(productPrice);
  }
}

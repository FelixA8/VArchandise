import 'package:intl/intl.dart';

enum Category {
  anime,
  disney,
  superhero,
  none,
}

class Cart {
  Cart({
    required this.id,
    required this.imgURL,
    required this.productTitle,
    required this.category,
    required this.price,
    required this.isSelected,
    required this.cartAmount,
  });
  int cartAmount;
  bool isSelected = false;
  String imgURL;
  String productTitle;
  Category category;
  double price;
  String id;

  String get getFormattedAccount {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(price);
  }
}

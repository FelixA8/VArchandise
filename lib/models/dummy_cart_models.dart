import 'package:uuid/uuid.dart';
import 'package:varchandise/models/cart_models.dart';

var uuid = const Uuid();

List<Cart> cartList = [
  Cart(
      id: uuid.v4(),
      imgURL: 'https://via.placeholder.com/1600x900',
      productTitle: 'Naruto sikutang',
      category: Category.anime,
      isSelected: false,
      cartAmount: 3,
      price: 500000),
  Cart(
      id: uuid.v4(),
      imgURL: 'https://via.placeholder.com/1600x900',
      productTitle: 'Naruto sigoblok',
      category: Category.anime,
      isSelected: false,
      cartAmount: 3,
      price: 450000),
  Cart(
      id: uuid.v4(),
      imgURL: 'https://via.placeholder.com/1600x900',
      productTitle: 'Naruto sianjing',
      category: Category.anime,
      isSelected: false,
      cartAmount: 3,
      price: 300000),
];

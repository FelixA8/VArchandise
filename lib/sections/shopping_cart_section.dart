import 'package:flutter/material.dart';
import 'package:varchandise/widgets/cart_listview.dart';

class ShoppingCartSection extends StatefulWidget {
  const ShoppingCartSection({super.key});

  @override
  State<ShoppingCartSection> createState() => _ShoppingCartSectionState();
}

class _ShoppingCartSectionState extends State<ShoppingCartSection> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: CartListView()),
        ],
      ),
    );
  }
}

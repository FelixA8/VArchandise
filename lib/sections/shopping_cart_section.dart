import 'package:flutter/material.dart';
import 'package:varchandise/widgets/cart_listview.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartSection extends StatefulWidget {
  const ShoppingCartSection({super.key});

  @override
  State<ShoppingCartSection> createState() => _ShoppingCartSectionState();
}

class _ShoppingCartSectionState extends State<ShoppingCartSection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Cart',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Expanded(child: CartListView()),
        ],
      ),
    );
  }
}

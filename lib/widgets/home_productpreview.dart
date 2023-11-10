import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/models/product_models.dart';
import 'package:varchandise/screens/product_screen.dart';

class ProductPreviewHome extends StatelessWidget {
  const ProductPreviewHome({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    void goToProductScreen() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ));
    }

    return GestureDetector(
      onTap: goToProductScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 393 / 500,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                product.productImageURL,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Text(
            product.productName,
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          Text(
            product.getFormattedPrice,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

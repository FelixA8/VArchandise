import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/models/product_models.dart';
import 'package:varchandise/screens/product_screen.dart';

class ProductPreviewHome extends StatelessWidget {
  const ProductPreviewHome({super.key, required this.listProducts});

  final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    void goToProductScreen(Product product) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ProductScreen(product: product);
        },
      ));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 200 / 300),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              goToProductScreen(listProducts[index]);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 20 / 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      listProducts[index].productImageURL,
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
                  listProducts[index].productName,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  listProducts[index].getFormattedPrice,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

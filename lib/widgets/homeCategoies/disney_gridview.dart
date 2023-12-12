import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/models/cart_models.dart';
import 'package:varchandise/models/product_models.dart';
import 'package:varchandise/screens/product_screen.dart';

class DisneyGridView extends StatelessWidget {
  const DisneyGridView({super.key, required this.listProducts});

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

    List<Product> animeList = listProducts
        .where((product) => product.productCategory == Category.disney)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: animeList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 200 / 300),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              goToProductScreen(animeList[index]);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 20 / 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      animeList[index].productImageURL,
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
                  animeList[index].productName,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Text(
                  animeList[index].getFormattedPrice,
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

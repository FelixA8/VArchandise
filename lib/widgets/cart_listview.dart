import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/models/dummy_cart_models.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        if (cartList.isEmpty) {
          return const Center(
            child: Text('No Cart!'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              width: 200,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 73 / 78,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.grey),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              "https://via.placeholder.com/73x78"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cartList[index].productTitle,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          cartList[index].category.name,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color.fromRGBO(0, 0, 0, 0.7)),
                        ),
                        Text(
                          cartList[index].getFormattedAccount,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            activeColor: const Color(0xff7408C2),
                            value: cartList[index].isSelected,
                            onChanged: (value) {
                              setState(() {
                                cartList[index].isSelected =
                                    !cartList[index].isSelected;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.trashCan,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.minus,
                                    size: 12,
                                    color: Color(0xff7408C2),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  cartList[index].cartAmount.toString(),
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                height: 20,
                                width: 20,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 12,
                                    color: Color(0xff7408C2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

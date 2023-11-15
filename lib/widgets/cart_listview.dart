import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/models/cart_models.dart';
import 'package:varchandise/rest/cartlist_api.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  SharedPreferences? sharedPreferences;
  String userID = "";

  Future getCustomerID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences!.getString('customerID').toString();
    Future<List<Cart>>? listOfCart;
    listOfCart = getAllUserCart(userID);
    return listOfCart;
  }

  @override
  Widget build(BuildContext context) {
    String totalPrice = "";
    void addItem(String cartID, int cartAmount, bool isSelected) async {
      cartAmount += 1;
      bool update =
          await updateNewUserCart(cartID, userID, cartAmount, isSelected);
      setState(() {});
    }

    void reduceItem(String cartID, int cartAmount, bool isSelected) async {
      cartAmount -= 1;
      bool update =
          await updateNewUserCart(cartID, userID, cartAmount, isSelected);
      setState(() {});
    }

    void checkItem(String cartID, int cartAmount, bool isSelected) async {
      bool update =
          await updateNewUserCart(cartID, userID, cartAmount, isSelected);
      setState(() {});
    }

    void deleteItem(String cartID, String userID) async {
      bool update = await deleteUserCart(cartID, userID);
      setState(() {});
    }

    Future<String> getTotalPrice() async {
      totalPrice = await getTotalCartPrice(userID);
      return totalPrice;
    }

    return FutureBuilder(
      future: getCustomerID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool anySelectedItem = false;

          List<Cart> listCart =
              snapshot.data as List<Cart>; // cast to List<Marker>
          void checkAnySelect() async {
            for (int i = 0; i < listCart.length; i++) {
              if (listCart[i].isSelected == true) {
                anySelectedItem = true;
                getTotalPrice().then((value) {
                  totalPrice = value;
                });
                return;
              }
            }
            anySelectedItem = false;
          }

          checkAnySelect();

          return listCart.isEmpty
              ? const Center(
                  child: Text('No Cart'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                              listCart[index].imgURL),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          listCart[index].productTitle,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          listCart[index].category.name,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.7)),
                                        ),
                                        Text(
                                          listCart[index]
                                              .getFormattedProductPrice,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            activeColor:
                                                const Color(0xff7408C2),
                                            value: listCart[index].isSelected,
                                            onChanged: (value) {
                                              listCart[index].isSelected =
                                                  !listCart[index].isSelected;
                                              checkItem(
                                                  listCart[index].cartID,
                                                  listCart[index].cartAmount,
                                                  listCart[index].isSelected);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: IconButton(
                                                  onPressed: () {
                                                    deleteItem(
                                                        listCart[index].cartID,
                                                        userID);
                                                  },
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
                                                child: listCart[index]
                                                            .cartAmount ==
                                                        1
                                                    ? IconButton(
                                                        onPressed: () {
                                                          reduceItem(
                                                              listCart[index]
                                                                  .cartID,
                                                              listCart[index]
                                                                  .cartAmount,
                                                              listCart[index]
                                                                  .isSelected);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          size: 12,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.2),
                                                        ),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          reduceItem(
                                                              listCart[index]
                                                                  .cartID,
                                                              listCart[index]
                                                                  .cartAmount,
                                                              listCart[index]
                                                                  .isSelected);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          size: 12,
                                                          color:
                                                              Color(0xff7408C2),
                                                        ),
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  listCart[index]
                                                      .cartAmount
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                height: 20,
                                                width: 20,
                                                child: IconButton(
                                                  onPressed: () {
                                                    addItem(
                                                        listCart[index].cartID,
                                                        listCart[index]
                                                            .cartAmount,
                                                        listCart[index]
                                                            .isSelected);
                                                  },
                                                  icon: const Icon(
                                                    FontAwesomeIcons.plus,
                                                    size: 12,
                                                    color: Color(0xff7408C2),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // ignore: unrelated_type_equality_checks
                    anySelectedItem
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total:       ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(totalPrice,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
        }
        return Center();
      },
    );
  }
}

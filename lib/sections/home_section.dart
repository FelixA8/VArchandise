import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/models/cart_models.dart';
import 'package:varchandise/models/category_types.dart';
import 'package:varchandise/models/product_models.dart';
import 'package:varchandise/rest/product_api.dart';
import 'package:varchandise/widgets/home_productpreview.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  SharedPreferences? _sharedPreferences;
  String userID = "";
  String userName = "";
  String userMail = "";

  void getUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userID = _sharedPreferences!.getString('customerID').toString();
    userName = _sharedPreferences!.getString('username').toString();
    userMail = _sharedPreferences!.getString('usermail').toString();
  }

  Future getAllProductsData() async {
    Future<List<Product>>? listOfProducts;
    listOfProducts = getProduct(userID);
    return listOfProducts;
  }

  void logOut() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences!.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Material(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    elevation: 20,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style:
                          GoogleFonts.poppins(color: const Color(0xff7408C2)),
                      decoration: const InputDecoration(
                        hintText: 'search',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xff7408C2)),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  items: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.trinityhealth.org/wp-content/uploads/2019/04/1600x900.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.trinityhealth.org/wp-content/uploads/2019/04/1600x900.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.trinityhealth.org/wp-content/uploads/2019/04/1600x900.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 30,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 30,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return CategoryButton(
                        title: categoryList[index].categTitle,
                        category: categoryList[index].category,
                      );
                    },
                  ),
                ),
                FutureBuilder(
                  future: getAllProductsData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // getMarkers() throws an exception
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    if (!snapshot.hasData) {
                      // getMarkers() returns null
                      return const Center(
                          child: Text(
                              "Oops, you do not have any product, ask your admin to put one :D"));
                    }
                    if (snapshot.hasData) {
                      List<Product> listProducts =
                          snapshot.data as List<Product>;
                      return ProductPreviewHome(listProducts: listProducts);
                    }
                    return const Center();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.title,
  });
  final String title;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: const Color(0xff7408C2),
      ),
      onPressed: () {},
      child: Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

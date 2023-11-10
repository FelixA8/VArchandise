import 'cart_models.dart';

List<Categ> categoryList = [
  Categ(categTitle: "All", category: Category.none),
  Categ(categTitle: "Anime", category: Category.anime),
  Categ(categTitle: "Disney", category: Category.disney),
  Categ(categTitle: "SuperHero", category: Category.superhero),
];

class Categ {
  Categ({required this.categTitle, required this.category});
  String categTitle;
  Category category;
}

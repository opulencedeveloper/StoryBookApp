import 'package:flutter/material.dart';

class FavoriteBook {
  String id;
  String title;
  String author;
  String imageUrl;

  FavoriteBook({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}

class FavoriteBooks extends ChangeNotifier {
  List<FavoriteBook> _favoriteBooks = [
    // FavoriteBook(
    //   id: 'b1',
    //   title: 'THE NINTH LIFE',
    //   author: 'Taylor B. Barton',
    //   imageUrl: 'https://i.ibb.co/bd96FzS/Rectangle-51.png',
    // ),
    // FavoriteBook(
    //   id: 'b1',
    //   title: 'THE NINTH LIFE',
    //   author: 'Taylor B. Barton',
    //   imageUrl: 'https://i.ibb.co/bd96FzS/Rectangle-51.png',
    // ),
    // FavoriteBook(
    //   id: 'b1',
    //   title: 'THE NINTH LIFE',
    //   author: 'Taylor B. Barton',
    //   imageUrl: 'https://i.ibb.co/bd96FzS/Rectangle-51.png',
    // ),
  ];

  List<FavoriteBook> get favoriteBooks {
    return [..._favoriteBooks];
  }

  void addFavoriteBook(String favBookId, String favBookTitle,
      String favBookImageUrl, String favBookAuthor) {
    final existingIndex =
        _favoriteBooks.indexWhere((meal) => meal.id == favBookId);
    if (existingIndex >= 0) {
      //final response = await http.delete(url);
      _favoriteBooks.removeAt(existingIndex);
      notifyListeners();
      // print(json.decode(response.body));
    } else {
      //try { //try catch was uncommented here beacuse we are already doing it on the widget, on the edit_product_screen where we called this function using "provider"
      // final response = await http.post(
      //   url,
      //   body: json.encode({
      //     "food": food,
      //     "imageUrl": imageUrl,
      //     "price": price,
      //   }),
      // );

      //print(json.decode(response.body));
      final newProduct = FavoriteBook(
        id: favBookId,
        title: favBookTitle,
        author: favBookAuthor,
        imageUrl: favBookImageUrl,
        //  isFavorite: isFav,
        //id: json.decode(response.body)["name"].toString(),
      );
      _favoriteBooks.add(newProduct);
    }

    notifyListeners();
  }

  bool isBookFavorite(String id) {
    return _favoriteBooks.any((book) => book.id == id);
  }
}

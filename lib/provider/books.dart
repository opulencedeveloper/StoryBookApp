import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Book {
  String id;
  String title;
  String author;
  String type;
  String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.type,
    required this.imageUrl,
  });
}

class Books extends ChangeNotifier {
  List<Book> _books = [
    // Book(
    //   id: 'b1',
    //   title: 'THE NINTH LIFE',
    //   author: 'Taylor B. Barton',
    //   type: 'recent',
    //   imageUrl: 'https://i.ibb.co/bd96FzS/Rectangle-51.png',
    // ),
    // Book(
    //   id: 'b2',
    //   title: 'CARBONEL',
    //   author: 'Barbara Sleign',
    //   type: 'recent',
    //   imageUrl: 'https://i.ibb.co/GtWRn5d/Rectangle-53.png',
    // ),
    // Book(
    //   id: 'b3',
    //   title: 'PAX',
    //   author: 'John Klaseen',
    //   type: 'new',
    //   imageUrl: 'https://i.ibb.co/x6pwT60/Rectangle-51-1.png',
    // ),
    // Book(
    //   id: 'b4',
    //   title: 'UNSEEN WORLD',
    //   author: 'Jamilla Francis',
    //   type: 'new',
    //   imageUrl: 'https://i.ibb.co/MpCNZ3Q/Rectangle-53-1.png',
    // ),
    // Book(
    //   id: 'b5',
    //   title: 'SNAP DRAGON',
    //   author: 'Kat Layh',
    //   type: 'more',
    //   imageUrl: 'https://i.ibb.co/86f2SmN/Rectangle-51-2.png',
    // ),
    // Book(
    //   id: 'b6',
    //   title: 'THE DREAMERS',
    //   author: 'Taylor B. Barton',
    //   type: 'more',
    //   imageUrl: 'https://i.ibb.co/yfsJ7nv/Rectangle-53-2.png',
    // ),
    // Book(
    //   id: 'b7',
    //   title: 'ARABIAN NIGHTS',
    //   author: 'By Rachael Thomson',
    //   type: 'recent',
    //   imageUrl: 'https://i.ibb.co/yfsJ7nv/Rectangle-53-2.png',
    // ),
  ];
  List<Book> get books {
    return [..._books];
  }

  List<Book> findBookType(String id) {
    return _books.where((p) => p.type == id).toList();
  }

  bool myTheme = true;

  bool get selectedTheme {
    return myTheme;
  }

  void setTheme(bool setTheme) {
    myTheme = setTheme;
    notifyListeners();
  }

  Book findBookById(String id) {
    return _books.firstWhere((doctor) => doctor.id == id);
  }

  Future<void> fetchAndSetBooks() async {
    //var url = Uri.parse("https://fin-tech-1878e-default-rtdb.firebaseio.com/users.json?auth=$authToken");
    var url = Uri.https(
        'story-book-d314a-default-rtdb.firebaseio.com', '/books.json');
    try {
      final response = await http.get(url);
      final extractedBooks = json.decode(response.body) as Map<String, dynamic>;
      if (extractedBooks == null) {
        return;
      }

      final List<Book> loadedBooks = [];
      extractedBooks.forEach((bookId, bookData) {
        loadedBooks.add(Book(
          id: bookId.toString(),
          title: bookData['title'].toString(),
          author: bookData['author'].toString(),
          type: bookData['type'].toString(),
          imageUrl: bookData['imageUrl'].toString(),
        ));
      });
      _books = loadedBooks;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}

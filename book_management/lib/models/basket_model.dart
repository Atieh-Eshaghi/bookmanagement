import 'package:book_management/models/book_model.dart';
import 'package:flutter/material.dart';

class BasketModel extends ValueNotifier<List<BookModel>> {
  List<BookModel> booksInBasket = [];
  static final BasketModel _instance = BasketModel._([]);
  BasketModel._(super.booksInBasket);
  static BasketModel get instance => _instance;

  addBook(BookModel book) {
    booksInBasket.add(book);
    book.addBookToBasket();
    notifyListeners();
  }

  removeBook(BookModel book) {
    booksInBasket.remove(book);
    book.removeBookFromBasket();
    notifyListeners();
  }

  emptyBasket() {
    for (var item in booksInBasket) {
      item.removeBookFromBasket();
    }
    booksInBasket = [];
    notifyListeners();
  }

  int get basketPrice {
    int price = 0;
    for (var item in booksInBasket) {
      price = price + item.price;
    }
    return price;
  }
}

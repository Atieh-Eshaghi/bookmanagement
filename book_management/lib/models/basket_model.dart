import 'package:book_management/models/book_model.dart';

class BasketModel {
  List<BookModel> booksInBasket = [];
  static final BasketModel _instance = BasketModel._();
  BasketModel._();
  static BasketModel get instance => _instance;

  addBook(BookModel book) {
    booksInBasket.add(book);
    book.addBookToBasket();
  }

  removeBook(BookModel book) {
    booksInBasket.remove(book);
    book.removeBookFromBasket();
  }

  int get basketPrice {
    int price = 0;
    for (var item in booksInBasket) {
      price = price + item.price;
    }
    return price;
  }
}

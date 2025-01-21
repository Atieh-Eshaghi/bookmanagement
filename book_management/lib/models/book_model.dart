import 'package:book_management/models/authentication.dart';
import 'package:flutter/material.dart';

class BookModel extends ValueNotifier<bool> {
  final String title;
  final int price;
  final String genre;
  final String imagePath;
  final String author;
  final String userId;
  final int pageCount;
  final String id;
  final bool isSoled;
  bool isInBasket = false;

  BookModel(super.isInBasket,
      {required this.title,
      required this.price,
      required this.id,
      required this.imagePath,
      required this.genre,
      required this.author,
      required this.isSoled,
      required this.pageCount,
      required this.userId});

  void addBookToBasket() {
    isInBasket = true;
    notifyListeners();
  }

  bool get isMine {
    return userId == Authentication.user?.id;
  }

  void removeBookFromBasket() {
    isInBasket = false;
    notifyListeners();
  }

  bool containInSearch(String searchText) {
    if (title.contains(searchText) ||
        genre.contains(searchText) ||
        author.contains(searchText)) {
      return true;
    }
    return false;
  }

  static List<BookModel> fakeData = [
    BookModel(false,
        title: "اثر مرکب",
        price: 450000,
        id: "235325",
        imagePath: "assets/images/book1.jpg",
        genre: "کمدی",
        isSoled: false,
        author: "خداد حسینی",
        pageCount: 121,
        userId: "test"),
    BookModel(false,
        title: "عادت های اتمی",
        price: 330000,
        id: "7457547",
        imagePath: "assets/images/book2.jpg",
        genre: "انگیزشی",
        author: "محمد محمدی",
        isSoled: false,
        pageCount: 532,
        userId: "admin"),
    BookModel(false,
        title: "قورباغه ات را قورت بده",
        price: 960000,
        id: "854734",
        imagePath: "assets/images/book3.jpg",
        genre: "مهندسی",
        isSoled: false,
        author: "حسین حسین زاده",
        pageCount: 245,
        userId: "user7"),
    BookModel(false,
        title: "اثر مرکب",
        price: 450000,
        id: "235325",
        isSoled: false,
        imagePath: "assets/images/book1.jpg",
        genre: "کمدی",
        author: "خداد حسینی",
        pageCount: 121,
        userId: "test"),
    BookModel(false,
        title: "عادت های اتمی",
        price: 330000,
        id: "7457547",
        imagePath: "assets/images/book2.jpg",
        genre: "انگیزشی",
        isSoled: false,
        author: "محمد محمدی",
        pageCount: 532,
        userId: "admin"),
    BookModel(false,
        title: "قورباغه ات را قورت بده",
        price: 960000,
        id: "8547434",
        imagePath: "assets/images/book3.jpg",
        genre: "مهندسی",
        isSoled: false,
        author: "حسین حسین زاده",
        pageCount: 245,
        userId: "user7"),
    BookModel(false,
        title: "اثر مرکب",
        price: 450000,
        id: "2353325",
        imagePath: "assets/images/book1.jpg",
        genre: "کمدی",
        author: "خداد حسینی",
        isSoled: false,
        pageCount: 121,
        userId: "test"),
    BookModel(false,
        title: "عادت های اتمی",
        price: 330000,
        id: "74572547",
        imagePath: "assets/images/book2.jpg",
        genre: "انگیزشی",
        isSoled: false,
        author: "محمد محمدی",
        pageCount: 532,
        userId: "user 54"),
    BookModel(false,
        title: "قورباغه ات را قورت بده",
        price: 960000,
        id: "85473534",
        imagePath: "assets/images/book3.jpg",
        genre: "مهندسی",
        isSoled: false,
        author: "حسین حسین زاده",
        pageCount: 245,
        userId: "user7"),
  ];
}

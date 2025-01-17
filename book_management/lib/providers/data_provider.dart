import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // لیست کتاب‌ها
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> get books => _books;

  // شناسه کاربر
  int? _userId;
  int? get userId => _userId;

  // نام کاربر
  String? _userName;
  String? get userName => _userName;

  // ثبت‌نام کاربر
  void registerUser(int id, String name) {
    _userId = id;
    _userName = name;
    notifyListeners();
  }

  // افزودن کتاب به لیست
  void addBook(Map<String, dynamic> book) {
    _books.add(book);
    notifyListeners();
  }

  // به‌روزرسانی لیست کتاب‌ها
  void updateBooks(List<Map<String, dynamic>> newBooks) {
    _books = newBooks;
    notifyListeners();
  }

  // پاک‌سازی داده‌های کاربر
  void logout() {
    _userId = null;
    _userName = null;
    _books = [];
    notifyListeners();
  }
}

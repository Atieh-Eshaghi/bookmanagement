import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/data_provider.dart';
import 'screens/home_screen.dart';
import 'screens/books_page.dart';
import 'screens/add_book_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()), // ایجاد Provider برای مدیریت داده‌ها
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // مسیر پیش‌فرض
      routes: {
        '/': (context) => HomeScreen(), // صفحه اصلی
        '/books': (context) => BooksPage(), // صفحه نمایش کتاب‌ها
        '/addBook': (context) => AddBookPage(), // صفحه افزودن کتاب
      },
      debugShowCheckedModeBanner: false, // حذف بنر اشکال‌زدایی
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // دریافت لیست کتاب‌ها از Provider
    final books = context.watch<DataProvider>().books;

    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: books.isEmpty
          ? Center(
              child: Text(
                  'No books available')) // در صورتی که کتابی وجود نداشته باشد
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book['title']),
                  subtitle: Text('Price: \$${book['price']}'),
                );
              },
            ),
    );
  }
}

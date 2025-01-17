import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/books'); // هدایت به صفحه نمایش کتاب‌ها
              },
              child: Text('View Books'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addBook'); // هدایت به صفحه افزودن کتاب
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}

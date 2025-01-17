import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();

  Future<void> _addBook(String title, int price, int owner) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/addBook'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'price': price,
          'owner': owner,
          'Bby': -1, // مقدار پیش‌فرض
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book added successfully!')),
        );
        // پاک کردن فیلدها پس از افزودن موفق
        _titleController.clear();
        _priceController.clear();
        _ownerController.clear();
      } else {
        throw Exception('Failed to add book');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ownerController,
              decoration: InputDecoration(
                labelText: 'Owner ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final price = int.tryParse(_priceController.text) ?? 0;
                final owner = int.tryParse(_ownerController.text) ?? 0;

                if (title.isNotEmpty && price > 0 && owner > 0) {
                  _addBook(title, price, owner);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields correctly')),
                  );
                }
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}

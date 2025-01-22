import 'package:book_management/models/book_model.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widget/book.dart';
import '../../widget/bottom_navigation.dart';
import 'add_or_edit_book_page.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  final List<BookModel> myBooks = BookModel.fakeData;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.textColor25,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.textColor100, width: 2))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Text(
                    "کتاب های من",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddOrEditBookPage(
                book: null,
              ),
            ));
          },
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
        body: ListView.builder(
          itemCount: myBooks.length,
          itemBuilder: (context, index) {
            BookModel book = myBooks[index];
            return BookItem(
              book: book,
              showBuyButton: false,
              onDelete: (BookModel book) {
                myBooks.remove(book);
                setState(() {
                  
                });
              },
            );
          },
        ),
        bottomNavigationBar:
            CustomBottomNavigation(activeType: BottomNvigationType.mybooks),
      ),
    );
  }
}

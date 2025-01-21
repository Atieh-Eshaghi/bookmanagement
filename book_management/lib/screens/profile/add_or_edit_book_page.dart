import 'package:book_management/models/book_model.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AddOrEditBookPage extends StatefulWidget {
  final BookModel? book;
  const AddOrEditBookPage({super.key , required this.book});

  @override
  State<AddOrEditBookPage> createState() => _AddOrEditBookPageState();
}

class _AddOrEditBookPageState extends State<AddOrEditBookPage> {

  void addOrUpdateBookApi(BookModel book){
    if (book.id.isEmpty){
      // todo add
    }else{
      // todo update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  widget.book == null ?"افزودن کتاب" : "ویرایش ${widget.book!.title}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )),
    );
  }
}

import 'package:book_management/models/authentication.dart';
import 'package:book_management/models/basket_model.dart';
import 'package:book_management/models/book_model.dart';
import 'package:book_management/widget/buttons.dart';
import 'package:book_management/widget/textfileds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../../widget/book.dart';
import '../../widget/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchEdittingController;
  List<BookModel> books = BookModel.fakeData;
  final List<BookModel> allBooks = BookModel.fakeData;
  bool isSearchActive = false;

  @override
  void initState() {
    searchEdittingController = TextEditingController();
    searchEdittingController.addListener(
      () {
        searchBooks(searchEdittingController.text);
      },
    );
    super.initState();
  }

  void searchBooks(String text) {
    if (text.isEmpty) {
      setState(() {
        isSearchActive = false;
        books = allBooks;
      });
    } else {
      isSearchActive = true;
      books = [];
      for (var item in allBooks) {
        if (item.containInSearch(text)) {
          books.add(item);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigation(
          activeType: BottomNvigationType.home,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.textColor25,
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.textColor50, width: 2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "سلام ${Authentication.user?.name} 🖐",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppColors.textColor800),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "به برنامه فروشگاه کتاب خوش آمدید",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AppColors.textColor500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: AppTextFiledWidget(
                          labelText: "جستجو",
                          textInputType: TextInputType.text,
                          textEditingController: searchEdittingController,
                          needAutoCorrect: true,
                          isPassword: false),
                    ),
                    if (isSearchActive)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                            "نتایج جستجو برای ${searchEdittingController.text}"),
                      ),
                  ],
                ),
              ),
              if(books.isEmpty)
              Expanded(
                child:Center(child: Text("هیچ کتابی یافت  نشد"),),
              ),
              if(books.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    BookModel book = books[index];
                    return BookItem(book: book);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

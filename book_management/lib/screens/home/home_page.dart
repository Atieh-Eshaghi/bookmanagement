import 'package:book_management/models/authentication.dart';
import 'package:book_management/models/basket_model.dart';
import 'package:book_management/models/book_model.dart';
import 'package:book_management/widget/buttons.dart';
import 'package:book_management/widget/textfileds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';
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
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigation(
        activeType: BottomNvigationType.home,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
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

class BookItem extends StatefulWidget {
  final BookModel book;
  const BookItem({super.key, required this.book});

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  void initState() {
    widget.book.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.textColor100)),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 100,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColors.primaryColor300,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.book.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.book.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: AppColors.textColor900),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "(${widget.book.genre})",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(color: AppColors.textColor500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "نویسنده اثر : ${widget.book.author}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: AppColors.textColor500),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "تعداد صفحه : ${widget.book.pageCount} صفحه",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: AppColors.textColor500),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(priceSeperator(widget.book.price)),
                    Spacer(),
                    AddToBasketButtonWidget(
                      buttonText: widget.book.isInBasket
                          ? "حذف از سبد"
                          : "افزودن به سبد",
                      isRemove: widget.book.isInBasket,
                      onPressed: () {
                        if (widget.book.isInBasket) {
                          BasketModel.instance.removeBook(widget.book);
                        } else {
                          BasketModel.instance.addBook(widget.book);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

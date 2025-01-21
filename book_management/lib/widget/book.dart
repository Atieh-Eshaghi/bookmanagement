import 'package:book_management/models/basket_model.dart';
import 'package:book_management/screens/profile/add_or_edit_book_page.dart';
import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'buttons.dart';

class BookItem extends StatefulWidget {
  final BookModel book;
  final bool showBuyButton;
  const BookItem({super.key, required this.book , this.showBuyButton = true});

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
                    Spacer(),
                    if(!widget.showBuyButton)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddOrEditBookPage(book: widget.book,),
                            ));
                      },
                      child: Icon(Icons.edit))
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
                    if (!widget.showBuyButton)
                        Text(
                          widget.book.isSoled ? "فروخته شده" : "فروخته نشده",
                          style: Theme.of(context).textTheme.titleMedium!.apply(
                              color: widget.book.isSoled
                                  ? AppColors.successColor200
                                  : AppColors.errorColor200),
                        ),
                        if (widget.showBuyButton)
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

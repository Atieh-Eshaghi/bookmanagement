import 'package:book_management/models/basket_model.dart';
import 'package:book_management/widget/bottom_navigation.dart';
import 'package:book_management/widget/buttons.dart';
import 'package:flutter/material.dart';

import '../../models/book_model.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../../widget/book.dart';
import '../orders/order_page.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  bool loading = false;
  @override
  void initState() {
    BasketModel.instance.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CustomBottomNavigation(activeType: BottomNvigationType.basket),
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
                  "سبد خرید",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Positioned.fill(
              child: BasketModel.instance.booksInBasket.isEmpty
                  ? Center(
                      child: Text(
                        "محصولی در سبد خرید موجود نمی باشد",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: AppColors.textColor500),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 100, top: 10),
                      itemCount: BasketModel.instance.booksInBasket.length,
                      itemBuilder: (context, index) {
                        BookModel book =
                            BasketModel.instance.booksInBasket[index];
                        return BookItem(book: book);
                      },
                    ),
            ),
            if (BasketModel.instance.booksInBasket.isNotEmpty)
              Positioned(
                  bottom: 5,
                  right: 5,
                  left: 5,
                  child: AppButtonWidget(
                    loading: loading,
                    buttonText:
                        "پرداخت (${priceSeperator(BasketModel.instance.basketPrice)})",
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      // to do send to order api
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {
                        loading = false;
                      });
                      BasketModel.instance.emptyBasket();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrdersPage(),
                      ));
                      
                    },
                  )),
          ],
        ),
      ),
    );
  }
}

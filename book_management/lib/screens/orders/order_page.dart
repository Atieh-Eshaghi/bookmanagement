import 'package:book_management/models/book_model.dart';
import 'package:book_management/models/order_model.dart';
import 'package:book_management/widget/book.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widget/bottom_navigation.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<OrderModel> order = OrderModel.fakeData;
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
                    "سفارشات من",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )),
        body: ListView.builder(
          itemCount: OrderModel.fakeData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            OrderModel model = OrderModel.fakeData[index];
            return Container(
              padding: EdgeInsets.all(17),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                  color: AppColors.textColor25,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.textColor100)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "سفارش شماره ${model.id}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "تاریخ : ${model.date}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ساعت : ${model.time}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "تعداد : ${model.orderCount}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "هزینه : ${model.orderPrice}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          showListDialog(context, model.books);
                        },
                        child: Row(
                          children: [
                            Text(
                              "جزییات سفارش",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(color: AppColors.primaryColor300),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: AppColors.primaryColor300,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar:
            CustomBottomNavigation(activeType: BottomNvigationType.orders),
      ),
    );
  }

  void showListDialog(BuildContext context, List<BookModel> items) {
    for (var item in items) {
      item.isSoled = true;
    }
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(4),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: double.infinity,
              height: 500, // Adjust height based on your needs
              decoration: BoxDecoration(
                  color: AppColors.textColor25,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'لیست کتاب ها',
                      style:
                          Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Divider(
                    color: AppColors.textColor100,
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookItem(
                          book: items[index],
                          showBuyButton: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

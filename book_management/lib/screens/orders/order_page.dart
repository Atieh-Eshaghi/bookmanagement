import 'package:book_management/models/order_model.dart';
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
                  "سفارشات من",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )),
      bottomNavigationBar:
          CustomBottomNavigation(activeType: BottomNvigationType.orders),
    );
  }
}

import 'package:book_management/screens/basket/basket_page.dart';
import 'package:book_management/screens/orders/order_page.dart';
import 'package:book_management/screens/profile/my_books_page.dart';
import 'package:book_management/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum BottomNvigationType { home, basket, orders, mybooks }

class CustomBottomNavigation extends StatelessWidget {
  final BottomNvigationType activeType;
  const CustomBottomNavigation({super.key, required this.activeType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: AppColors.textColor25,
          border: Border(top: BorderSide(color: AppColors.textColor100))),
      child: Row(
        children: [
          BottomNvigationItem(
            activeType: activeType,
            type: BottomNvigationType.home,
          ),
          BottomNvigationItem(
            activeType: activeType,
            type: BottomNvigationType.basket,
          ),
          BottomNvigationItem(
            activeType: activeType,
            type: BottomNvigationType.orders,
          ),
          BottomNvigationItem(
            activeType: activeType,
            type: BottomNvigationType.mybooks,
          ),
        ],
      ),
    );
  }
}

class BottomNvigationItem extends StatelessWidget {
  final BottomNvigationType activeType;
  final BottomNvigationType type;
  const BottomNvigationItem({
    super.key,
    required this.activeType,
    required this.type,
  });

  bool get isActive {
    return type == activeType;
  }

  String get icon {
    switch (type) {
      case BottomNvigationType.home:
        return "assets/icons/home.svg";
      case BottomNvigationType.basket:
        return "assets/icons/basket.svg";
      case BottomNvigationType.orders:
        return "assets/icons/order.svg";
      case BottomNvigationType.mybooks:
        return "assets/icons/user.svg";
    }
  }

  String get text {
    switch (type) {
      case BottomNvigationType.home:
        return "خانه";
      case BottomNvigationType.basket:
        return "سبدخرید";
      case BottomNvigationType.orders:
        return "سفارشات";
      case BottomNvigationType.mybooks:
        return "کتاب من";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (!isActive) {
            if (type == BottomNvigationType.home) {
              Navigator.of(context).pop();
            } else if (type == BottomNvigationType.basket) {
              if (activeType == BottomNvigationType.home) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BasketPage(),
                ));
              }else{
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BasketPage(),
                ));
              }
            } else if (type == BottomNvigationType.orders) {
              if (activeType == BottomNvigationType.home) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrdersPage(),
                ));
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrdersPage(),
                ));
              }
            } else if (type == BottomNvigationType.mybooks) {
              if (activeType == BottomNvigationType.home) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyBooksPage(),
                ));
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyBooksPage(),
                ));
              }
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primaryColor300 : AppColors.textColor400,
                  BlendMode.srcIn),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                  color: isActive
                      ? AppColors.primaryColor300
                      : AppColors.textColor400),
            )
          ],
        ),
      ),
    );
  }
}

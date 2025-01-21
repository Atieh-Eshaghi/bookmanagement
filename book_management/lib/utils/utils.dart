import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'colors.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: AppColors.textColor0),
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: AppColors.errorColor100,
    ),
  );
}

void showMessage(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: AppColors.textColor0),
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: AppColors.successColor100,
    ),
  );
}

String priceSeperator(dynamic number, {bool hasDecimal = false}) {
  var formatter =
      hasDecimal ? intl.NumberFormat('#,###.##') : intl.NumberFormat('#,###');
  var price = formatter.format(number.toDouble());
  return "$price تومان";
}

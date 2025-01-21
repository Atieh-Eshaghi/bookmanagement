import 'package:flutter/material.dart';

import 'colors.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage , style: Theme.of(context).textTheme.titleMedium!.apply(color: AppColors.textColor0), textDirection: TextDirection.rtl,),
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

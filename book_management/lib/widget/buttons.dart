import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final bool loading;
  const AppButtonWidget({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: loading == false ? onPressed : null,
          style: buttonStyle(),
          child: loading == false
              ? Text(
                  buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.textColor0),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: AppColors.textColor0,
                ))),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: BorderSide(width: 1.0, color: AppColors.primaryColor300),
            borderRadius: BorderRadius.circular(21.0))),
        backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.primaryColor300),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0)));
  }
}

class AddToBasketButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  final bool isRemove;
  final bool loading;
  const AddToBasketButtonWidget({
    super.key,
    required this.buttonText,
    this.isRemove = false,
    this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: ElevatedButton(
          onPressed: loading == false ? onPressed : null,
          style: isRemove? removeButtonStyle() : buttonStyle(),
          child: loading == false
              ? Text(
                  buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.textColor0),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: AppColors.textColor0,
                ))),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: BorderSide(width: 1.0, color: AppColors.primaryColor300),
            borderRadius: BorderRadius.circular(13.0))),
        backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.primaryColor300),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0)));
  }

   ButtonStyle removeButtonStyle() {
    return ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            side: BorderSide(width: 1.0, color: AppColors.errorColor200),
            borderRadius: BorderRadius.circular(13.0))),
        backgroundColor:
            WidgetStateProperty.all<Color>(AppColors.errorColor200),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0)));
  }
}

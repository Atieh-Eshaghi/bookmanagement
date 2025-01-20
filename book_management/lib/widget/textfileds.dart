import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';


class AppTextFiledWidget extends StatefulWidget {
  final String? labelText;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool needAutoCorrect;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final String? hint;
  final bool showRemoveButton;
  final String? errorMessage;
  final bool enabled;

  const AppTextFiledWidget(
      {super.key,
      required this.labelText,
      required this.textInputType,
      required this.textEditingController,
      required this.needAutoCorrect,
      required this.isPassword,
      this.hint,
      this.textAlign = TextAlign.right,
      this.enabled = true,
      this.textDirection = TextDirection.rtl,
      this.showRemoveButton = false,
      this.errorMessage});

  @override
  State<AppTextFiledWidget> createState() => _AppTextFiledWidgetState();
}

class _AppTextFiledWidgetState extends State<AppTextFiledWidget> {
  int lenText = 0;
  bool showPassword = false;
  final bool isError = false;

  @override
  Widget build(BuildContext context) {
    widget.textEditingController.addListener(
      () {
        try {
          setState(() {
            lenText = widget.textEditingController.text.length;
          });
          // ignore: empty_catches
        } catch (e) {}
      },
    );
    return SizedBox(
      height: widget.errorMessage == null ? 60 : 85,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword && !showPassword,
        autocorrect: widget.needAutoCorrect,
        enabled: widget.enabled,
        controller: widget.textEditingController,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        decoration: textFieldDecoration(context),
      ),
    );
  }

  InputDecoration textFieldDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hint,
      errorText: widget.errorMessage,
      filled: true,
      fillColor: AppColors.backgroundColor,
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor200, width: 1.2),
          borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor100, width: 1.2),
          borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor300, width: 1.2),
          borderRadius: BorderRadius.circular(16)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor200, width: 1.2),
          borderRadius: BorderRadius.circular(16)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor100, width: 1.2),
          borderRadius: BorderRadius.circular(16)),
      label: widget.labelText != null
          ? Text(
              widget.labelText!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: AppColors.textColor900),
            )
          : null,
      suffixIcon: widget.isPassword
          ? InkWell(
              child: Icon(showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            )
          : widget.showRemoveButton == true && lenText > 0
              ? InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: SvgPicture.asset(
                      "assets/icons/remove-text-textfiled.svg",
                      width: 15,
                      height: 15,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.textEditingController.text = "";
                    });
                  },
                )
              : null,
    );
  }
}

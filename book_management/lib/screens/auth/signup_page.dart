import 'package:book_management/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../../widget/textfileds.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  bool loading = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 350,
                  color: AppColors.primaryColor300,
                  child: Center(
                      child: SvgPicture.asset("assets/images/login.svg"))),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor300,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "به برنامه مدیریت کتاب خوش آمدید👋",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "برای ثبت نام، نام کاربری، رمزعبور و نام خود را وارد نمایید!",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextFiledWidget(
                        labelText: "نام کاربری",
                        textInputType: TextInputType.text,
                        isPassword: false,
                        textEditingController: usernameController,
                        needAutoCorrect: false,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      AppTextFiledWidget(
                        labelText: "رمز عبور",
                        textInputType: TextInputType.visiblePassword,
                        isPassword: true,
                        textEditingController: passwordController,
                        needAutoCorrect: false,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      AppTextFiledWidget(
                        labelText: "نام و نام خانوادگی",
                        textInputType: TextInputType.text,
                        isPassword: false,
                        textEditingController: nameController,
                        needAutoCorrect: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppButtonWidget(
                        buttonText: "ثبت نام",
                        loading: loading,
                        onPressed: () async {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          String name = nameController.text;

                          if (username.isEmpty) {
                            showError(
                                context, "نام کاربری نمی تواند خالی باشد!");
                            return;
                          }
                          if (password.isEmpty) {
                            showError(context, "رمزعبور نمی تواند خالی باشد!");
                            return;
                          }
                          if (password.length < 8) {
                            showError(context,
                                "رمزعبور نمی تواند کمتر از 8 کاراکتر باشد!");
                            return;
                          }

                          if (name.isEmpty) {
                            showError(context, "نام نمی تواند خالی باشد!");
                            return;
                          }

                          setState(() {
                            loading = true;
                          });
                          // todo signup api call
                          await Future.delayed(Duration(seconds: 5));
                          Navigator.of(context).pop();
                          showMessage(context, "حساب با موفقیت ساخته شد!");
                          // todo signup api call
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "قبلا ثبت نام نموده اید؟",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "وارد شوید",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(color: AppColors.primaryColor200),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:book_management/screens/auth/signup_page.dart';
import 'package:book_management/utils/utils.dart';
import 'package:book_management/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../../widget/textfileds.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool loading = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
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
                        height: 35,
                      ),
                      Text(
                        "برای ورود نام کاربری و رمز عبور خود را وارد نمایید",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 35,
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
                        height: 20,
                      ),
                      AppButtonWidget(
                        buttonText: "ورود",
                        loading: loading,
                        onPressed: () async {
                          String username = usernameController.text;
                          String password = passwordController.text;

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
                          setState(() {
                            loading = true;
                          });
                          // todo login api call
                          await Future.delayed(Duration(seconds: 5));
                          if (username == "admin" && password == "12345678") {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                          } else {
                            showError(
                                context, "نام کاربری یا رمز عبور اشتباه است");
                          }
                          setState(() {
                            loading = false;
                          });
                          // todo login api call
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "تاکنون حساب کاربری نداشته اید؟",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ));
                            },
                            child: Text(
                              "ثبت نام کنید",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(color: AppColors.primaryColor200),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Text(
                        "تهیه شده توسط عطیه السادات اسحاقی",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: AppColors.textColor400),
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

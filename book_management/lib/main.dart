import 'package:book_management/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/data_provider.dart';
import 'screens/home_screen.dart';
import 'screens/books_page.dart';
import 'screens/add_book_page.dart';
import 'utils/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                DataProvider()), // ایجاد Provider برای مدیریت داده‌ها
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle mainTextStyle300 =
        TextStyle(color: AppColors.textColor900, fontFamily: "Yekan");

    TextStyle mainTextStyle200 =
        TextStyle(color: AppColors.textColor600, fontFamily: "Yekan");

    TextStyle mainTextStyle100 =
        TextStyle(color: AppColors.textColor400, fontFamily: "Yekan");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Book Management',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor300,
          onSecondary: AppColors.textColor300,
        ),
        textTheme: TextTheme(
          headlineLarge: mainTextStyle300.copyWith(
              fontWeight: FontWeight.w800, fontSize: 21),
          headlineMedium: mainTextStyle300.copyWith(
              fontWeight: FontWeight.w800, fontSize: 18),
          headlineSmall: mainTextStyle200.copyWith(
              fontWeight: FontWeight.w800, fontSize: 16),
          bodyLarge: mainTextStyle300.copyWith(fontSize: 18),
          titleLarge: mainTextStyle300.copyWith(
              fontWeight: FontWeight.w800, fontSize: 19),
          titleMedium: mainTextStyle200.copyWith(
              fontWeight: FontWeight.w600, fontSize: 16),
          titleSmall: mainTextStyle100.copyWith(
              fontWeight: FontWeight.w600, fontSize: 14),
          bodyMedium: mainTextStyle200.copyWith(fontSize: 15),
          bodySmall: mainTextStyle100.copyWith(fontSize: 13),
          labelSmall: mainTextStyle100.copyWith(fontSize: 11),
        ),
      ),
      // initialRoute: '/', // مسیر پیش‌فرض
      // routes: {
      //   '/': (context) => HomeScreen(), // صفحه اصلی
      //   '/books': (context) => BooksPage(), // صفحه نمایش کتاب‌ها
      //   '/addBook': (context) => AddBookPage(), // صفحه افزودن کتاب
      // },
      home: LoginPage(),
      
      locale: const Locale.fromSubtags(languageCode: "fa"),
      debugShowCheckedModeBanner: false, // حذف بنر اشکال‌زدایی
    );
  }
}

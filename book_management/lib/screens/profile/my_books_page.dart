
import 'package:flutter/material.dart';

import '../../widget/bottom_navigation.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigation(activeType: BottomNvigationType.mybooks),
    );
  }
}
import 'package:book_management/models/book_model.dart';
import 'package:shamsi_date/shamsi_date.dart';

class OrderModel {
  final String id;
  final int timeStamp;
  final List<BookModel> books;

  OrderModel({required this.id, required this.timeStamp, required this.books});

  static List<OrderModel> fakeData = [
    OrderModel(
        id: "54124",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        books: BookModel.fakeData),
    OrderModel(
        id: "54646",
        timeStamp: DateTime.now().millisecondsSinceEpoch - 1000000,
        books: BookModel.fakeData),
    OrderModel(
        id: "35346",
        timeStamp: DateTime.now().millisecondsSinceEpoch - 7000000,
        books: BookModel.fakeData),
  ];

  String get date {
    Jalali date =
        Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    return "${date.day}/${date.month}/${date.year}";
  }

  String get time {
    Jalali date =
        Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    return "${date.hour}:${date.hour}";
  }

  String get orderPrice {
    int price = 0;
    for (var item in books) {
      price = price + item.price;
    }
    return "$price";
  }

  int get orderCount {
    return books.length;
  }
}

import 'package:book_management/models/book_model.dart';
import 'package:shamsi_date/shamsi_date.dart';

class OrderModel {
  final String id;
  final int timeStamp;
  final List<BookModel> books;

  OrderModel({required this.id, required this.timeStamp, required this.books});

  static List<OrderModel> fakeData = [];

  String get date {
    Jalali date =
        Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
  }
}

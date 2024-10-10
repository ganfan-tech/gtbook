import 'package:gtbook/model/entity/book.dart';
import 'package:uuid/uuid.dart';

class AppData {
  /// 作者
  String? author;

  late List<Book> books;

  AppData()
      : author = "",
        books = [];

  AppData.fromJson(Map<String, dynamic> json) {
    books = [];
    if (json['books'] != null) {
      json['books'].forEach((v) {
        books.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['author'] = author ?? "";

    final bookJsonList = [];
    for (var v in books) {
      bookJsonList.add(v.toJson());
    }
    data['books'] = bookJsonList;

    return data;
  }
}

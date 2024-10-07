import 'package:uuid/uuid.dart';

class Book {
  /// bookId
  late String bookId;

  /// 书名
  late String name;

  /// 作者
  String? author;

  /// 本地路径
  String? localPath;

  late List<Chapter> chapters;

  /// 创建时间
  BigInt? createdTime;

  /// 更新时间
  BigInt? updatedTime;

  Book(
    this.name,
  ) : bookId = const Uuid().v4();

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    name = json['name'];
    localPath = json['localPath'];
  }
}

class Chapter {
  String chapterId;

  String title;

  /// 创建时间
  BigInt? createdTime;

  /// 更新时间
  BigInt? updatedTime;

  /// booId，所属book的ID
  late String bookId;

  late String content;
  late List<Chapter> children;

  Chapter(this.title) : chapterId = const Uuid().v4();
}

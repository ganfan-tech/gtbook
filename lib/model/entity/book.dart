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

    chapters = [];
    if (json['chapters'] != null) {
      json['chapters'].forEach((v) {
        chapters.add(Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = bookId;
    data['name'] = name;
    data['localPath'] = localPath;
    return data;
  }
}

class Chapter {
  late String chapterId;
  late String title;

  /// 创建时间
  BigInt? createdTime;

  /// 更新时间
  BigInt? updatedTime;

  /// booId，所属book的ID
  late String bookId;

  /// 文件名，对应文件系统里的文件
  /// 由系统管理，不能修改
  late String filename;
  late String content;

  late List<Chapter> chapters;

  Chapter(this.title) : chapterId = const Uuid().v4();

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    title = json['title'];
    bookId = json['bookId'];
    filename = json['filename'];

    chapters = [];
    if (json['chapters'] != null) {
      json['chapters'].forEach((v) {
        chapters.add(Chapter.fromJson(v));
      });
    }
  }
}

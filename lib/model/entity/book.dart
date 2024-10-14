import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Book {
  /// bookId
  late String bookId;

  /// 书名
  late String name;

  /// 作者
  String? author;

  late List<Chapter> chapters;

  /// 创建时间
  String? createdTime;

  /// 更新时间
  String? updatedTime;

  Book(
    this.name,
  ) : bookId = const Uuid().v4() {
    var now = DateTime.now();
    var nowStr = DateFormat("y-M-d h:m:s").format(now);
    createdTime = nowStr;
    updatedTime = nowStr;
  }

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    name = json['name'];

    chapters = [];
    if (json['chapters'] != null) {
      json['chapters'].forEach((v) {
        chapters.add(Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bookId'] = bookId;
    data['name'] = name;
    return data;
  }

  void initContent() {
    chapters = [];
  }

  Map<String, dynamic> toContentJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = bookId;
    data['name'] = name;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;

    var chaptersJsonList = [];
    for (var v in chapters) {
      chaptersJsonList.add(v.toJson());
    }
    data['chapters'] = chaptersJsonList;

    return data;
  }
}

class Chapter {
  /// 章节ID
  late String chapterId;

  /// 直接标题
  late String title;

  /// 创建时间
  String? createdTime;

  /// 更新时间
  String? updatedTime;

  /// booId，所属book的ID
  late String bookId;

  /// 内容
  late String content;

  /// 子章节
  late List<Chapter> chapters;

  Chapter(this.bookId, this.title) : chapterId = const Uuid().v4();

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    title = json['title'];
    bookId = json['bookId'];

    var now = DateTime.now();
    var nowStr = DateFormat("y-M-d h:m:s").format(now);
    createdTime = nowStr;
    updatedTime = nowStr;

    chapters = [];
    if (json['chapters'] != null) {
      json['chapters'].forEach((v) {
        chapters.add(Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bookId'] = bookId;
    data['chapterId'] = chapterId;
    data['title'] = title;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    return data;
  }
}

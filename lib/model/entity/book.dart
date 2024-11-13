import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Book {
  /// bookId
  late String bookId;

  /// 书名
  late String name;

  /// 作者
  String? author;

  /// 创建时间
  String? createdTime;

  /// 更新时间
  String? updatedTime;

  /// 书的章节
  late List<Chapter> chapters;

  late Directory bookdir;

  Book(
    this.name,
  ) : bookId = const Uuid().v4() {
    var now = DateTime.now();
    var nowStr = DateFormat("y-M-d h:m:s").format(now);
    createdTime = nowStr;
    updatedTime = nowStr;
  }

  Book.basicFromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    name = json['name'];

    chapters = [];
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

  loadBookIndexFile() async {
    // 读取 book 目录下的 gtbook.json 文件
    final file = File(path.join(bookdir.path, "gtbook.json"));
    if (await file.exists()) {
      String contents = await file.readAsString();
      var json = jsonDecode(contents); // 解码 JSON 字符串为 Map

      chapters = [];
      if (json['chapters'] != null) {
        json['chapters'].forEach((v) {
          chapters.add(Chapter.fromJson(v, this));
        });
      }
    } else {
      // 创建文件
      await file.create();
      // Book 初始化内容数据
      initContent();
      // 格式化 json 输出
      String jsonString =
          const JsonEncoder.withIndent("  ").convert(toContentJson());

      await file.writeAsString(jsonString);
    }
  }

  syncBookIndexFile() async {
    String jsonString =
        const JsonEncoder.withIndent("  ").convert(toContentJson());

    final file = File(path.join(bookdir.path, "gtbook.json"));

    file.writeAsString(jsonString);
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

  late Book _book;

  /// 内容
  late Future<String> content;

  /// 子章节
  late List<Chapter> chapters;

  Chapter(this.bookId, this.title) : chapterId = const Uuid().v4();

  Chapter.fromJson(Map<String, dynamic> json, Book book) {
    _book = book;

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
        chapters.add(Chapter.fromJson(v, book));
      });
    }
  }

  Future<void> loadContentFromFile() async {
    final file = File(path.join(_book.bookdir.path, "$chapterId.md"));
    if (!await file.exists()) {
      // 创建文件
      await file.create();
    }
    content = file.readAsString();
  }

  void syncContentToFile() async {
    final file = File(path.join(_book.bookdir.path, "$chapterId.md"));
    if (!await file.exists()) {
      // 创建文件
      await file.create();
    }

    await file.writeAsString(await content, flush: true);
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

import 'package:uuid/uuid.dart';

class Book {
  /// ID
  late String id;

  /// 书名
  late String name;

  /// 作者
  String? author;

  /// 本地路径
  String? localPath;

  /// 创建时间
  BigInt? createdTime;

  /// 更新时间
  BigInt? updatedTime;

  Book(
    this.name,
  ) : id = const Uuid().v4();

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localPath = json['localPath'];
  }
}

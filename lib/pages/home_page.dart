import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtbook/appflowy_editor_example/appflowy_editor_example.dart';
import 'package:gtbook/components/book_card.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:gtbook/pages/new_book_page.dart';
import 'package:universal_platform/universal_platform.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var books = [
    Book.fromJson({"bookId": "231231", "name": "数学", "localPath": ""}),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
    Book("数学"),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
    Book("数学"),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
    Book("数学"),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
    Book("数学"),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
    Book("数学"),
    Book("Nginx"),
    Book("Web"),
    Book("iOS"),
    Book("macOS"),
    Book("Flutter"),
    Book("计算机组成"),
    Book("数据结构与算法"),
    Book("网络"),
    Book("数据库"),
    Book("Linux"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: UniversalPlatform.isDesktopOrWeb,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 134, 46, 247),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('GTBook'),
        actions: [
          IconButton(
            icon: const Icon(Icons.abc),
            onPressed: () {
              Get.to(AppflowyEditorExample());
            },
          )
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            // mainAxisSpacing: 20,
            // crossAxisSpacing: 20,
          ),
          children: books.map((item) {
            return BookCard(book: item);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(NewBookPage());
        },
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:gtbook/model/entity/app.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtbook/appflowy_editor_example/appflowy_editor_example.dart';
import 'package:gtbook/components/book_card.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:gtbook/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppData _appData = AppData();

  @override
  void initState() {
    super.initState();

    // 加载 book 列表
    _loadAppData();
  }

  @override
  void setState(fn, {bool isInit = false}) {
    super.setState(fn);
    if (!isInit) {
      _saveAppData();
    }
  }

  void _saveAppData() async {
    Directory appDir = await getApplicationSupportDirectory();
    // ~/Library/Containers/com.example.gtbook/Data/Library/Application Support/com.example.gtbook
    // 找到book的目录

    final appFile = File(path.join(appDir.path, "gtbooks.json"));
    String jsonString = const JsonEncoder.withIndent("  ").convert(_appData);
    await appFile.writeAsString(jsonString);
  }

  void _loadAppData() async {
    Directory appDir = await getApplicationSupportDirectory();
    // ~/Library/Containers/com.example.gtbook/Data/Library/Application Support/com.example.gtbook
    // 找到book的目录

    final appFile = File(path.join(appDir.path, "gtbooks.json"));
    if (await appFile.exists()) {
      String contents = await appFile.readAsString();
      var jsonstr = jsonDecode(contents); // 解码 JSON 字符串为 Map
      var appData = AppData.fromJson(jsonstr);
      _appData = appData;
      setState(() {});
    } else {
      // 创建文件
      await appFile.create();
      var appData = AppData();
      // 保存文件内容
      // 格式化 json 输出
      String jsonString = const JsonEncoder.withIndent("  ").convert(appData);

      await appFile.writeAsString(jsonString);
      _appData = appData;
      setState(() {}, isInit: true);
    }
  }

  // 弹窗输入函数
  Future<String?> _showInputDialog() async {
    TextEditingController _textFieldController = TextEditingController();

    // 显示对话框并获取输入
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your new book name'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_textFieldController.text);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );

    return result;
  }

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
          children: _appData.books.map((book) {
            return BookCard(
              book: book,
              onTap: () {
                // TODO 判断文件目录是否存在，是否可用
                Get.toNamed(
                  Routes.book,
                  arguments: book,
                );
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () async {
          var name = await _showInputDialog();
          if (name == null || name.trim().isEmpty) {
            return;
          }
          var newBook = Book(name);
          _appData.books.insert(0, newBook);
          setState(() {});
        },
      ),
    );
  }
}

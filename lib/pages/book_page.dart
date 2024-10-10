import 'dart:convert';
import 'dart:io';
import 'package:gtbook/common/file.dart';
import 'package:path/path.dart' as path;
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gtbook/appflowy_editor_example/pages/editor.dart';
import 'package:gtbook/components/book_card.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:yaml/yaml.dart' as yaml;

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late WidgetBuilder _widgetBuilder;
  late EditorState _editorState;
  late Future<String> _jsonString;

  @override
  void initState() {
    super.initState();
    Book? book = Get.arguments;
    if (book == null) {
      print(book);
    } else {
      print(book.bookId + book.name);
    }

    readDirectory();

    _jsonString = UniversalPlatform.isDesktopOrWeb
        ? rootBundle.loadString('assets/appflowy_editor_example/example.json')
        : rootBundle
            .loadString('assets/appflowy_editor_example/mobile_example.json');

    // _widgetBuilder = (context) => Editor(
    //       jsonString: _jsonString,
    //       onEditorStateChange: (editorState) {
    //         _editorState = editorState;
    //       },
    //     );
  }

  readDirectory() async {
    // 文件路径
    Directory d = await getApplicationSupportDirectory();
    print(d);
    // ~/Library/Containers/com.example.gtbook/Data/Library/Application Support/com.example.gtbook
    // 找到book的目录
    var bookdir = path.join(d.path, 'mybook');
    final directory = Directory(bookdir);

    // 如果文件夹不存在，创建它
    if (!await directory.exists()) {
      await directory.create(recursive: true); // recursive: true 确保递归创建文件夹
      print('文件夹创建成功：$bookdir');
    } else {
      print('文件夹已存在：$bookdir');
    }

    // 读取 book 目录下的 gtbook.json 文件
    final file = File(path.join(directory.path, "gtbook.json"));
    if (await file.exists()) {
      String contents = await file.readAsString();
      var jsonstr = jsonDecode(contents); // 解码 JSON 字符串为 Map
      var book = Book.fromJson(jsonstr);
      print(book.bookId);
    } else {
      // 创建文件
      await file.create();
      // 保存文件内容
      var book = Book("mybook");
      // 格式化 json 输出
      String jsonString = const JsonEncoder.withIndent("  ").convert(book);

      await file.writeAsString(jsonString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 134, 46, 247),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('GTBook'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 300,
            color: Colors.red[50],
            child: ListView(
              children: [
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("  Chapter 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
                ListTile(title: Text("Section 01")),
              ],
            ),
          ),
          Expanded(
            child: Container(
                // child: SafeArea(
                //   maintainBottomViewPadding: true,
                //   // child: _widgetBuilder(context),
                // ),
                ),
          ),
        ],
      ),
    );
  }
}

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
  Book _book = Get.arguments;

  Chapter? _currentChapter = null;

  @override
  void initState() {
    super.initState();

    readDirectory();
  }

  readDirectory() async {
    // 文件路径
    Directory d = await getApplicationSupportDirectory();
    // ~/Library/Containers/com.example.gtbook/Data/Library/Application Support/com.example.gtbook
    // 找到book的目录
    var bookdir = path.join(d.path, _book.bookId);
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
      _book = book;
      setState(() {});
    } else {
      // 创建文件
      await file.create();
      // Book 初始化内容数据
      _book.initContent();
      // 格式化 json 输出
      String jsonString =
          const JsonEncoder.withIndent("  ").convert(_book.toContentJson());

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
              children: _book.chapters.map((i) {
                return ListTile(
                  title: Text(i.title),
                  selected: i.chapterId == _currentChapter?.chapterId,
                  onTap: () {
                    _currentChapter = i;
                    setState(() {});
                  },
                );
              }).toList(),
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () async {
          var name = await _showInputDialog();
          if (name == null || name.trim().isEmpty) {
            return;
          }
          var newChapter = Chapter(name);
          _book.chapters.add(newChapter);
          setState(() {});
        },
      ),
    );
  }

  // 弹窗输入函数
  Future<String?> _showInputDialog() async {
    TextEditingController _textFieldController = TextEditingController();

    // 显示对话框并获取输入
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your new chapter title'),
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
}

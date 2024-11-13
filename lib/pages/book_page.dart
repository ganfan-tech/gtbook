import 'dart:async';
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

  File? _thisBookIndexFile = null;

  WidgetBuilder? _widgetBuilder;

  EditorState? _editorState;

  @override
  void initState() {
    super.initState();

    _loadBookInfo();
  }

  void _loadBookInfo() async {
    // 文件路径
    Directory d = await getApplicationSupportDirectory();
    // ~/Library/Containers/com.example.gtbook/Data/Library/Application Support/com.example.gtbook
    // 找到book的目录
    var bookpath = path.join(d.path, _book.bookId);
    final directory = Directory(bookpath);

    // 如果文件夹不存在，创建它
    if (!await directory.exists()) {
      await directory.create(recursive: true); // recursive: true 确保递归创建文件夹
      print('文件夹创建成功：$bookpath');
    } else {
      print('文件夹已存在：$bookpath');
    }

    _book.bookdir = directory;
    _book.loadBookIndexFile();
    setState(() {});
  }

  void _syncBookInfo() {
    String jsonString =
        const JsonEncoder.withIndent("  ").convert(_book.toContentJson());

    _thisBookIndexFile!.writeAsString(jsonString);
  }

  void createChapter(String title) {
    var newChapter = Chapter(_book.bookId, title);
    newChapter.content = Future<String>.value("# $title\n");
    _book.chapters.add(newChapter);

    _currentChapter = newChapter;
    _loadEditor();

    // 创建 chapter file
    newChapter.syncContentToFile();

    // 更新 gtbook.json 文件
    _syncBookInfo();
  }

  void switchCurrentChapter(Chapter chapter) async {
    _currentChapter = chapter;
    await _currentChapter!.loadContentFromFile();
    _loadEditor();
    setState(() {});
  }

  Future<void> _loadEditor() async {
    final completer = Completer<void>();

    var jsonMap = markdownToDocument(await _currentChapter!.content).toJson();
    var jsonString = jsonEncode(jsonMap);

    wb(context) {
      return Editor(
        jsonString: Future<String>.value(jsonString),
        onEditorStateChange: (editorState) {
          _editorState = editorState;
          var md = documentToMarkdown(editorState.document);
          _currentChapter!.content = Future.value(md);
          _currentChapter!.syncContentToFile();
          // 更新本地文件内容
        },
      );
    }

    _widgetBuilder = wb;

    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete();
    });
    return completer.future;
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
            child: ListView(
              children: _book.chapters.map((i) {
                return ListTile(
                  title: Text(i.title),
                  selected: i.chapterId == _currentChapter?.chapterId,
                  selectedColor: Colors.red,
                  selectedTileColor: Colors.red[50],
                  onTap: () {
                    switchCurrentChapter(i);
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _currentChapter == null || _widgetBuilder == null
                ? Container()
                : Container(
                    child: SafeArea(
                      maintainBottomViewPadding: true,
                      child: Column(
                        children: [
                          Expanded(
                            child: _widgetBuilder!(context),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () async {
          var title = await _showInputDialog();
          if (title == null || title.trim().isEmpty) {
            return;
          }
          createChapter(title);
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

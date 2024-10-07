import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gtbook/appflowy_editor_example/pages/editor.dart';
import 'package:gtbook/components/book_card.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:universal_platform/universal_platform.dart';

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

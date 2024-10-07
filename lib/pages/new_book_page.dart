import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gtbook/appflowy_editor_example/pages/editor.dart';
import 'package:gtbook/components/book_card.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:universal_platform/universal_platform.dart';

class NewBookPage extends StatefulWidget {
  const NewBookPage({super.key});

  @override
  State<NewBookPage> createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  @override
  void initState() {
    super.initState();
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
      body: Container(
        width: 300,
        color: Colors.red[50],
        child: ListView(
          children: [
            ListTile(title: Text("Name")),
            ListTile(
              title: Text("Location"),
              onTap: () async {
                String? selectedDirectory =
                    await FilePicker.platform.getDirectoryPath();

                if (selectedDirectory == null) {
                  print("User canceled the picker");
                } else {
                  print(selectedDirectory);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

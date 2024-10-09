import 'dart:convert';
import 'dart:io'; // 用于文件操作
import 'package:path_provider/path_provider.dart'; // 获取路径

// getApplicationSupportDirectory
// 支持多种操作系统

// Windows：getApplicationSupportDirectory() 会返回 C:\Users\<用户名>\AppData\Roaming\<应用程序名> 目录。
// macOS：getApplicationSupportDirectory() 会返回 /Users/<用户名>/Library/Application Support/<应用程序名> 目录。
// Linux：getApplicationSupportDirectory() 会返回 /home/<用户名>/.local/share/<应用程序名> 目录。
// iOS：使用 getApplicationSupportDirectory() 返回的路径是在 /Library/Application Support/<应用程序名> 下，这是 iOS 推荐的用于持久存储应用数据的目录。
// 该目录是私有的，只有该应用能访问，系统会自动进行备份。
// Android：使用 getApplicationSupportDirectory() 返回的路径是应用在 Android 沙盒中的 data/data/<应用程序包名>/files/ 目录。
// 该目录同样是私有的，只有应用程序自身能访问，不需要权限。

// 获取应用程序支持的目录
class FileUtils {
  static Future<String> getAppDataPath() async {
    // 获取系统的应用程序支持目录
    Directory directory = await getApplicationSupportDirectory();
    return directory.path; // 返回路径
  }

  /// 保存数据到文件
  static Future<void> saveData(String filename, String data) async {
    String path = await getAppDataPath();
    File file = File('$path/$filename');
    await file.writeAsString(data); // 将字符串写入文件
  }

  /// 从文件中读取数据
  static Future<String> readData(String filename) async {
    try {
      String path = await getAppDataPath();
      File file = File('$path/$filename');
      String data = await file.readAsString(); // 读取文件中的数据
      return data;
    } catch (e) {
      print("读取文件时出错: $e");
      return "null";
    }
  }

  /// 读取 JSON 文件
  static Future<Map<String, dynamic>> readJsonFile(String filename) async {
    final file = File(filename);
    if (await file.exists()) {
      String contents = await file.readAsString();
      return jsonDecode(contents); // 解码 JSON 字符串为 Map
    } else {
      throw Exception('文件不存在');
    }
  }
}

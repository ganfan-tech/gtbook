import 'package:get/get.dart';
import 'package:gtbook/pages/book_page.dart';
import 'package:gtbook/pages/home_page.dart';

abstract class Routes {
  static String get home => '/';
  static String get book => '/book';

  static List<GetPage> getPages() {
    return [
      GetPage(name: home, page: () => HomePage()),
      GetPage(name: book, page: () => BookPage()),
    ];
  }
}

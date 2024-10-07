import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:gtbook/routes.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.book,
          arguments: book,
        );
      },
      child: Card(
        child: Title(
          child: Text(book.name),
          color: Colors.black,
        ),
      ),
    );
  }
}

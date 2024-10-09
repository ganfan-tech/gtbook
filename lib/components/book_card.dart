import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtbook/model/entity/book.dart';
import 'package:gtbook/routes.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final GestureTapCallback? onTap;

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Title(
          child: Text(book.name),
          color: Colors.black,
        ),
      ),
    );
  }
}

import 'package:book_app/book_view.dart';
import 'package:flutter/material.dart';
import 'epub.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: BookScreen()
    );
  }
}
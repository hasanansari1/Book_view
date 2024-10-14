import 'package:flutter/material.dart';
import 'book_view.dart';
import 'book_view2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const BookPage(),
    );
  }
}
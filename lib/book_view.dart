import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<String> bookPages = [
    'assets/images/emart.png',
    'assets/images/imgs.jpg',
    'assets/images/wait.png',
    'assets/images/logo.jpg',
    'assets/images/emart.png',
    'assets/images/emart.png',
    'assets/images/imgs.jpg',
    'assets/images/wait.png',
    'assets/images/logo.jpg',
    'assets/images/emart.png',
    'assets/images/emart.png',
    'assets/images/imgs.jpg',
    'assets/images/wait.png',
    'assets/images/logo.jpg',
    'assets/images/emart.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Book'),
        backgroundColor: Colors.brown[700], // Matching the book theme
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Simulate the book spine with gradient for realistic look
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.brown[800]!, Colors.brown[600]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 8.0,
                        offset: Offset(3, 3), // Make it look like a spine
                      ),
                    ],
                  ),
                ),
              ),
              // Animated book widget with flipping functionality
              AnimatedBookWidget(bookPages: bookPages),
              // Adding subtle shadows to create depth
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animated_book_widget/animated_book_widget.dart';


class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Animated Book'),
      ),
      body: Center(
        child: AnimatedBookWidget(
          cover: _buildCover(),
          content: _buildContent(),
          size: const Size(300, 400),
          padding: const EdgeInsets.only(right: 10),
          blurRadius: 8,
          spreadRadius: 0.1,
          backgroundBlurOffset: Offset.zero,
          backgroundColor: Colors.blue.withOpacity(0.5),
          backgroundShadowColor: Colors.blue.withOpacity(0.075),
          curve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          reverseAnimationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }

  Widget _buildCover() {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/book_cover.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'My Book Title',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 3.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    List<String> pageImages = [
      'assets/images/emart.png',
      'assets/images/img.png',
      'assets/images/logo.jpg',
      'assets/images/wait.png',
      'assets/images/a.jpg',
    ];

    return PageView.builder(
      itemCount: pageImages.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(pageImages[index]),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Page ${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
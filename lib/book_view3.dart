import 'package:flutter/material.dart';
import 'dart:math' as math;

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentPage = 0;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _turnPage(bool forward) {
    setState(() {
      _isForward = forward;
      if (forward) {
        _currentPage = math.min(_currentPage + 1, 4);
      } else {
        _currentPage = math.max(_currentPage - 1, 0);
      }
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Animated Book'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: Stack(
            children: [
              _buildCover(),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_isForward ? -(_controller.value  math.pi / 2) : (1 - _controller.value)  math.pi / 2),
                    child: _isForward ? _buildCurrentPage() : _buildNextPage(),
                  );
                },
              ),
            ],
          ),
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

  Widget _buildCurrentPage() {
    return GestureDetector(
      onTap: () => _turnPage(true),
      child: _buildPageContent(_currentPage),
    );
  }

  Widget _buildNextPage() {
    return GestureDetector(
      onTap: () => _turnPage(false),
      child: _buildPageContent(_currentPage - 1),
    );
  }

  Widget _buildPageContent(int index) {
    List<String> pageImages = [
      'assets/images/emart.png',
      'assets/images/img.png',
      'assets/images/logo.jpg',
      'assets/images/wait.png',
      'assets/images/a.jpg',
    ];

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
  }
}
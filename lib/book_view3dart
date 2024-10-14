import 'package:flutter/material.dart';
import 'dart:math' as math;

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentPage = -1; // -1 represents the front cover
  bool _isForward = true;
  bool _isCoverOpen = false;

  final List<String> pageImages = [
    'assets/images/emart.png',
    'assets/images/img.png',
    'assets/images/logo.jpg',
    'assets/images/wait.png',
    'assets/images/a.jpg',
    'assets/images/emart.png',
    'assets/images/emart.png',
    'assets/images/img.png',
    'assets/images/logo.jpg',
    'assets/images/wait.png',
    'assets/images/a.jpg',
    'assets/images/emart.png',
    'assets/images/emart.png',
    'assets/images/img.png',
    'assets/images/logo.jpg',
    'assets/images/wait.png',
    'assets/images/a.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _turnPage(bool forward) {
    if ((_currentPage == 0 && !forward) ||
        (_currentPage >= pageImages.length - 2 && forward)) {
      return; // Don't turn if we're at the start or end of the book
    }
    setState(() {
      _isForward = forward;
      if (forward) {
        _currentPage += 2;
      } else {
        _currentPage -= 2;
      }
    });
    _controller.forward(from: 0.0);
  }

  void _openCover() {
    setState(() {
      _isCoverOpen = true;
      _currentPage = 0;
    });
    _controller.forward(from: 0.0);
  }

  void _closeCover() {
    setState(() {
      _isCoverOpen = false;
      _currentPage = -1;
    });
    _controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Realistic Book'),
      ),
      body: Center(
        child: Container(
          width: 600,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.brown[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (!_isCoverOpen) _buildCover(true),
              if (_isCoverOpen) ...[
                Row(
                  children: [
                    Expanded(child: _buildPageContent(_currentPage + 1)),
                    Expanded(child: _buildPageContent(_currentPage)),
                  ],
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-_controller.value * math.pi),
                      child: Row(
                        children: [
                          Expanded(
                            child: _isForward
                                ? _buildPageContent(_currentPage)
                                : _buildPageContent(_currentPage + 1),
                          ),
                          Expanded(
                            child: _isForward
                                ? _buildPageContent(_currentPage + 1)
                                : _buildPageContent(_currentPage + 2),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
              if (_currentPage >= pageImages.length - 1) _buildCover(false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCover(bool isFrontCover) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(-_controller.value * math.pi),
          child: GestureDetector(
            onTap: isFrontCover ? _openCover : _closeCover,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.brown[700]!, Colors.brown[600]!],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isFrontCover ? 'My Book Title' : 'The End',
                  style: const TextStyle(
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageContent(int index) {
    if (index < 0 || index >= pageImages.length) {
      return Container(color: Colors.white);
    }

    return GestureDetector(
      onTap: () => _turnPage(index % 2 == 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(pageImages[index]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: 20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.black.withOpacity(0.1)
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
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
          ],
        ),
      ),
    );
  }
}
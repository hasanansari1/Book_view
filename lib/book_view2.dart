import 'package:flutter/material.dart';

class ImageAnimatedBookPage extends StatefulWidget {
  final List<String> pageImages = [
    'assets/images/logo.jpg',
    'assets/images/login.jpg',
    'assets/images/img.png',
    'assets/images/emart.png',
    'assets/images/a.jpg',
  ];

  @override
  _ImageAnimatedBookPageState createState() => _ImageAnimatedBookPageState();
}

class _ImageAnimatedBookPageState extends State<ImageAnimatedBookPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('My Picture Book'),
        backgroundColor: Colors.brown[700],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              // Move to the next page on tap
              _currentPage = (_currentPage + 1) % widget.pageImages.length;
            });
          },
          child: AnimatedBookWidget(
            width: 300,
            height: 450,
            currentPage: _currentPage,
            bookPages: [
              BookPageWidget(
                page: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'My Picture Book',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                widget.pageImages.length,
                    (index) => BookPageWidget(
                  page: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              widget.pageImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text('Failed to load image'),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Page ${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class AnimatedBookWidget extends StatefulWidget {
  final List<Widget> bookPages;
  final double width;
  final double height;
  final int currentPage;

  const AnimatedBookWidget(
      {super.key, required this.bookPages,
        required this.width,
        required this.height,
        required this.currentPage});

  @override
  _AnimatedBookWidgetState createState() => _AnimatedBookWidgetState();
}

class _AnimatedBookWidgetState extends State<AnimatedBookWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          ...widget.bookPages.asMap().entries.map((entry) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: entry.key < widget.currentPage ? -widget.width : 0,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: entry.value,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class BookPageWidget extends StatelessWidget {
  final Widget page;

  const BookPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return page;
  }
}

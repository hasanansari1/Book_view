// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class BookPage1 extends StatefulWidget {
//   @override
//   _BookPage1State createState() => _BookPage1State();
// }
//
// class _BookPage1State extends State<BookPage1>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   int _currentPage = -1; // -1 represents the front cover
//   bool _isForward = true; // To determine the direction of the flip
//   bool _isCoverOpen = false; // To check if cover is open
//   bool _isTurningPage = false; // To check if a page is currently turning
//
//   final List<String> pageImages = [
//     'assets/images/emart.png',
//     'assets/images/img.png',
//     'assets/images/logo.jpg',
//     'assets/images/wait.png',
//     'assets/images/a.jpg',
//     'assets/images/emart.png',
//     'assets/images/emart.png',
//     'assets/images/img.png',
//     'assets/images/logo.jpg',
//     'assets/images/wait.png',
//     'assets/images/a.jpg',
//     'assets/images/emart.png',
//     'assets/images/emart.png',
//     'assets/images/img.png',
//     'assets/images/logo.jpg',
//     'assets/images/wait.png',
//     'assets/images/a.jpg',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _turnPage(bool forward) {
//     // Don't turn if we're at the start or end of the book
//     if ((_currentPage == 0 && !forward) ||
//         (_currentPage >= pageImages.length - 1 && forward) ||
//         _isTurningPage) {
//       return;
//     }
//     setState(() {
//       _isForward = forward;
//       _isTurningPage = true; // Set turning state
//       if (forward) {
//         _currentPage++; // Move to next page
//       } else {
//         _currentPage--; // Move to previous page
//       }
//     });
//     _controller.forward(from: 1.0).whenComplete(() {
//       setState(() {
//         _isTurningPage = false; // Reset turning state
//       });
//     });
//   }
//
//   void _openCover() {
//     setState(() {
//       _isCoverOpen = true;
//       _currentPage = 0;
//     });
//     _controller.forward(from: 0.0);
//   }
//
//   void _closeCover() {
//     setState(() {
//       _isCoverOpen = false;
//       _currentPage = -1;
//     });
//     _controller.reverse(from: 1.0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Animated Book'),
//       ),
//       body: Center(
//         child: SizedBox(
//           width: 600,
//           height: 400,
//           child: Stack(
//             children: [
//               if (!_isCoverOpen) _buildCover(true),
//               if (_isCoverOpen) ...[
//                 Row(
//                   children: [
//                     Expanded(child: _buildPageContent(_currentPage)),
//                     Expanded(child: _buildPageContent(_currentPage + 1)),
//                   ],
//                 ),
//                 AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return Transform(
//                       alignment: Alignment.centerRight,
//                       transform: Matrix4.identity()
//                         ..setEntry(3, 2, 0.001)
//                         ..rotateY(_isForward
//                             ? -_controller.value * math.pi
//                             : _controller.value * math.pi),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _isForward
//                                 ? _buildPageContent(_currentPage)
//                                 : _buildPageContent(_currentPage + 1),
//                           ),
//                           Expanded(
//                             child: _isForward
//                                 ? _buildPageContent(_currentPage + 1)
//                                 : _buildPageContent(_currentPage + 2),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//               if (_currentPage >= pageImages.length - 1) _buildCover(false),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCover(bool isFrontCover) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Transform(
//           alignment: Alignment.centerRight,
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.001)
//             ..rotateY(-_controller.value * math.pi),
//           child: GestureDetector(
//             onTap: isFrontCover ? _openCover : _closeCover,
//             child: Container(
//               width: 300,
//               decoration: BoxDecoration(
//                 color: Colors.brown[700],
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   isFrontCover ? 'My Book Title' : 'The End',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 3.0,
//                         color: Colors.black,
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildPageContent(int index) {
//     if (index < 0 || index >= pageImages.length) {
//       return Container(color: Colors.white);
//     }
//
//     return GestureDetector(
//       onTap: () {
//         // Call _turnPage with true for right tap (next page) or false for left tap (previous page)
//         _turnPage(index == _currentPage + 1);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(pageImages[index]),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Text(
//                 'Page ${index + 1}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BookPage1 extends StatefulWidget {
  const BookPage1({super.key});

  @override
  _BookPage1State createState() => _BookPage1State();
}

class _BookPage1State extends State<BookPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentPage = -1; // -1 represents the front cover
  bool _isForward = true; // To determine the direction of the flip
  bool _isCoverOpen = false; // To check if cover is open
  bool _isTurningPage = false; // To check if a page is currently turning

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
    // Don't turn if we're at the start or end of the book
    if ((_currentPage == 0 && !forward) ||
        (_currentPage >= pageImages.length - 1 && forward) ||
        _isTurningPage) {
      return;
    }
    setState(() {
      _isForward = forward;
      _isTurningPage = true; // Set turning state
      if (forward) {
        _currentPage++; // Move to next page
      } else {
        _currentPage--; // Move to previous page
      }
    });
    _controller.forward(from: 0.0).whenComplete(() {
      setState(() {
        _isTurningPage = false; // Reset turning state
      });
    });
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
        title: const Text('My Animated Book'),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: Stack(
            children: [
              if (!_isCoverOpen) _buildCover(true),
              if (_isCoverOpen) ...[
                Row(
                  children: [
                    Expanded(child: _buildPageContent(_currentPage)),
                    Expanded(child: _buildPageContent(_currentPage + 1)),
                  ],
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // Back of the current page (left side)
                        if (_isForward && _currentPage < pageImages.length - 1)
                          Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_controller.value * math.pi),
                            child: _buildPageContent(_currentPage + 1),
                          ),

                        // Front of the next page (right side)
                        if (_isForward && _currentPage < pageImages.length - 1)
                          Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(-_controller.value * math.pi),
                            child: _buildPageContent(_currentPage),
                          ),
                      ],
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
                color: Colors.brown[700],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
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
      onTap: () {
        // Call _turnPage with true for right tap (next page) or false for left tap (previous page)
        _turnPage(index == _currentPage + 1);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(pageImages[index]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
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
      ),
    );
  }
}



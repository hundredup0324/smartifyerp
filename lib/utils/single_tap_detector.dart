import 'dart:async';

import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class SingleTapDetector extends StatelessWidget {
  final Widget child;

  SingleTapDetector({
    super.key,
    required this.child,
    required this.onButtonPressed,
    this.interval = 1000,
  });
  int interval;
  final VoidCallback onButtonPressed;
  var isClicked = false;
  late Timer _timer;

  _startTimer() {
    _timer = Timer(Duration(milliseconds: interval), () => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isClicked == false) {
          _startTimer();
          onButtonPressed();
          isClicked = true;
        }
      },
      child: child,
    );
  }
}
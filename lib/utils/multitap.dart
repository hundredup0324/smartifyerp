import 'package:flutter/material.dart';

mixin PreventMultipleTap<T extends StatefulWidget> on State<T> {
  bool _isProcessing = false;

  Future<void> handleTap(Future<void> Function() onTap) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      await onTap();
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      } else {
        _isProcessing = false;
      }
    }
  }
}
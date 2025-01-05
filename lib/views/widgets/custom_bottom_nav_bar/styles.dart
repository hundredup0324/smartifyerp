import 'package:flutter/cupertino.dart';
import 'custom_bottom_nav_bar.dart';
import 'fixed_circle_tab_style.dart';
import 'react_tab_style.dart';
import 'bar_item.dart';

DelegateBuilder supportedStyle(
  TabStyle style, {
  required List<CustomTabItem> items,
  required Color color,
  required Color activeColor,
  required Color backgroundColor,
  required Curve curve,
}) {
  assert(items.isNotEmpty, 'items should not be empty');
  assert(((style == TabStyle.fixedCircle) && items.length.isOdd) || (style != TabStyle.fixedCircle),
      'item count should be an odd number when using fixed/fixedCircle');
  DelegateBuilder builder;
  switch (style) {
    case TabStyle.fixedCircle:
      builder = FixedCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        convexIndex: items.length ~/ 2,
      );
      break;
    case TabStyle.reactCircle:
      builder = ReactTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
      );
      break;
  }
  return builder;
}

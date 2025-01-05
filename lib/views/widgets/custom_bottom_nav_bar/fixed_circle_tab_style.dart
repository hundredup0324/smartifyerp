// ignore_for_file: avoid_print

/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import '../../../utils/text_style.dart';
import 'bar_item.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center with circle.
class FixedCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder
  FixedCircleTabStyle(
      {required List<CustomTabItem> items,
      required Color activeColor,
      required Color color,
      required this.backgroundColor,
      required this.convexIndex})
      : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var c = active ? activeColor : color;
    var item = items[index];
    if (index == convexIndex) {
      final item = items[index];
      var icon = Container(
        width: 50, height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.cGreenFont,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: assetSvdImageWidget(
              image: active ? item.activeIcon ?? item.icon : item.icon,
              colorFilter: ColorFilter.mode(c, BlendMode.srcIn)),
        ),
      );
      var children = <Widget>[
        icon,
        Padding(
          padding: const EdgeInsets.only(top: 15,),
          child: Text(item.title ?? '', style: pSemiBold10.copyWith(color: c)),
        )
      ];

      return Padding(
        padding: const EdgeInsets.only(top: 8.0,right: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      );
    }

    var icon = assetSvdImageWidget(
        image: active ? item.activeIcon ?? item.icon : item.icon, colorFilter: ColorFilter.mode(c, BlendMode.srcIn));

    var children = (index == convexIndex)?<Widget>[]:<Widget>[
      icon,
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(item.title ?? '', style: pSemiBold10.copyWith(color: c)),
      )
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  @override
  bool fixed() {
    return true;
  }
}

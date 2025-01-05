import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/text_style.dart';
import 'package:attendance/views/widgets/custom_bottom_nav_bar/common_appbar_widget.dart';

class KnowledgeBaseDetail extends StatelessWidget {
  String? description;
  String? title;

  KnowledgeBaseDetail({super.key, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.cBackGround,
      appBar: simpleAppBar(title: title??""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Text(description??"",style: pRegular14),

      ),
    );
  }
}

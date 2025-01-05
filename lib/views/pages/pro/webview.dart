import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

   String? url;
   String? projectName;


   WebViewScreen({super.key,this.url,this.projectName});

  @override
  Widget build(BuildContext context) {

    WebViewController controller = WebViewController()
      ..loadRequest(
        Uri.parse(url??""),
      );
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      appBar: AppBar(
        title: Text(projectName??''),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

}
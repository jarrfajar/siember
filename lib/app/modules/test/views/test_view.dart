import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestView extends GetView<TestController> {
  var url = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.berita(url);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Container(
                  color: controller.status.isEmpty ? Colors.transparent : const Color(0xfffe73c61),
                  height: 3,
                  width: controller.status.isEmpty ? Get.width : Get.width * double.parse(controller.status.value),
                )),
            Expanded(child: WebViewWidget(controller: controller.webview!)),
          ],
        ),
      ),
    );
  }
}

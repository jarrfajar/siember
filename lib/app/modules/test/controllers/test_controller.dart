import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestController extends GetxController {
  WebViewController? webview;

  RxString status = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void berita(String url) {
    webview = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            status.value = progress.toString().padLeft(3, '0.');
            if (progress == 100) {
              status.value = '';
            }
          },
          onPageStarted: (String url) {
            status.value = '.10';
          },
          onPageFinished: (String url) {
            status.value = '';
          },
          onWebResourceError: (WebResourceError error) {
            if (status.value.isNotEmpty) {
              Get.snackbar('Error', error.errorType.toString());
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            int thirdSlashIndex = url.indexOf('/', url.indexOf('/', url.indexOf('/') + 1) + 1);
            String link = url.substring(0, thirdSlashIndex);
            if (request.url.startsWith(link)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
  }
}

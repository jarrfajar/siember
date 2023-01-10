import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview/app/data/models/category.dart';
import 'package:webview/app/data/models/news.dart';

class HomeController extends GetxController {
  // final String title;

  RxBool isLoading = false.obs;
  RxBool isLoadingNews = false.obs;

  RxInt current = 0.obs;

  final category = RxList<Category>();
  final news = RxList<News>();

  final categorytest = RxList<Category>();

  RxString urlNews = 'https://api-berita-indonesia.vercel.app/antara/terbaru/'.obs;

  RxString menu = 'terbaru'.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    await getCategory();
    await getNews(urlNews.value);
    isLoading.value = false;
    //
  }

  // REFRESH NEWS
  Future<void> refreshNews() async {
    menu.value = 'terbaru';
    await getNews(urlNews.value);
  }

  // CHANGE CATEGORY
  void change(int index, String uri, String name) {
    current.value = index;
    urlNews.value = uri;
    getNews(uri);

    menu.value = 'terbaru';
    var data = category.where((element) => element.name == name).toList();
    categorytest.clear();
    categorytest.addAll(data);
  }

  // CATEGORY
  Future<List<Category>> getCategory() async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse("https://api-berita-indonesia.vercel.app");
      var res = await http.get(uri);

      final List<Category> data = (json.decode(res.body) as Map<String, dynamic>)['endpoints']
          .map((json) => Category.fromJson(json))
          .toList()
          .cast<Category>();

      data.removeWhere((element) => element.name == 'tempo');

      if (res.statusCode == 200) {
        if (data.isNotEmpty && category.isEmpty) {
          category.addAll(data);
          // MENU
          var dataMenu = category.where((element) => element.name == 'antara').toList();
          categorytest.clear();
          categorytest.addAll(dataMenu);
        }
        return category;
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  // NEWS
  Future<List<News>> getNews(String url) async {
    try {
      isLoadingNews.value = true;
      Uri uri = Uri.parse(url);
      var res = await http.get(uri);

      final List<News> data = (json.decode(res.body) as Map<String, dynamic>)['data']['posts']
          .map((json) => News.fromJson(json))
          .toList()
          .cast<News>();

      if (res.statusCode == 200) {
        news.clear();
        news.addAll(data);
        return news;
      }
    } catch (e) {
      print(['error', e]);
    } finally {
      isLoadingNews.value = false;
    }
    return [];
  }
}

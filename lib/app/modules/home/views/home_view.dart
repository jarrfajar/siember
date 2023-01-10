import 'package:animated_stack/animated_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview/app/data/models/category.dart';
import 'package:webview/app/data/models/news.dart';
import 'package:webview/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4a2d6f),
      body: Obx(
        () => controller.isLoading.isTrue
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      "SiEmber",
                      style: TextStyle(
                        fontSize: 42.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 221, 220, 221),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Sistem Informasi Berita",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 221, 220, 221),
                      ),
                    ),
                  ),
                ],
              )
            : AnimatedStack(
                backgroundColor: const Color(0xfff28153d),
                fabBackgroundColor: const Color(0xfffe73c61),
                // MAIN PAGE
                foregroundWidget: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Color(0xfff4a2d6f),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CATEGORY
                          Obx(
                            () => controller.isLoading.isTrue
                                ? const Center(child: CircularProgressIndicator())
                                : SizedBox(
                                    height: 60.0,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(bottom: 10, left: 10),
                                      itemCount: controller.category.length,
                                      // itemCount: snapshot.data!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        Category menu = controller.category[index];

                                        return Obx(
                                          () => GestureDetector(
                                            onTap: () => controller.change(index, menu.paths!.first.path!, menu.name!),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                              margin: const EdgeInsets.only(right: 10.0, top: 10),
                                              decoration: BoxDecoration(
                                                color: index == controller.current.value
                                                    ? const Color(0xfff5f4680)
                                                    : Color.fromARGB(255, 221, 220, 221),
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  menu.name!.toUpperCase(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: index == controller.current.value
                                                        ? const Color.fromARGB(255, 221, 220, 221)
                                                        : const Color(0xfff5f4680),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),

                          // NEWS
                          Expanded(
                            child: Obx(
                              () => controller.isLoadingNews.isTrue
                                  ? const Center(child: CircularProgressIndicator())
                                  : RefreshIndicator(
                                      onRefresh: () => controller.refreshNews(),
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: controller.news.length,
                                        itemBuilder: (context, index) {
                                          News news = controller.news[index];
                                          var time = DateTime.parse(news.pubDate!);

                                          if (index % 3 == 0) {
                                            return GestureDetector(
                                              onTap: () => Get.toNamed(Routes.TEST, arguments: news.link),
                                              child: Card(
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                                color: const Color(0xfff5f4680),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        news.title!,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(255, 221, 220, 221),
                                                          fontSize: 17.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10.0),
                                                      Text(
                                                        news.description ?? "",
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(255, 221, 220, 221),
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
                                                      ),
                                                      const SizedBox(height: 10.0),
                                                      Text(
                                                        timeago.format(time),
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(255, 221, 220, 221),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return GestureDetector(
                                            onTap: () => Get.toNamed(Routes.TEST, arguments: news.link),
                                            child: Card(
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              color: const Color(0xfff5f4680),
                                              child: Padding(
                                                padding: const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: const EdgeInsets.only(right: 5),
                                                            // color: Colors.red,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  news.title!,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 3,
                                                                  style: const TextStyle(
                                                                    color: Color.fromARGB(255, 221, 220, 221),
                                                                    fontSize: 17.0,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 10.0),
                                                                Text(
                                                                  news.description ?? "",
                                                                  style: const TextStyle(
                                                                    color: Color.fromARGB(255, 221, 220, 221),
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 3,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              news.thumbnail ?? "https://i.ibb.co/S32HNjD/no-image.jpg",
                                                          imageBuilder: (context, imageProvider) => Container(
                                                            height: 110,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              image: DecorationImage(
                                                                image: imageProvider,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (context, url) => const SizedBox(
                                                            height: 110,
                                                            width: 100,
                                                            child: Center(
                                                              child: CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context, url, error) => Container(
                                                            height: 110,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[200],
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: const Icon(Icons.image),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10.0),
                                                    Text(
                                                      timeago.format(time),
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(255, 221, 220, 221),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                columnWidget: Obx(
                  () => controller.categorytest.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.categorytest.first.paths!.length,
                                itemBuilder: (context, index) {
                                  Paths test = controller.categorytest.first.paths![index];

                                  return GestureDetector(
                                    onTap: () {
                                      controller.menu.value = test.name!;
                                      controller.getNews(test.path!);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      padding: const EdgeInsets.all(5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        // color: Color(0xfff56476b),
                                        color: const Color(0xfff5f4680),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          test.name!.capitalizeFirst!,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(255, 221, 220, 221),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                ),
                scaleWidth: 100,
                bottomWidget: Container(
                  height: 35,
                  width: Get.width * 0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f4680),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        controller.menu.value.capitalizeFirst!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 221, 220, 221),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flappy_search_bar_ns/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controller/lobby_controller.dart';
import '../model/Post.dart';
import 'detail.dart';


class Lobby extends GetView<LobbyController> {
  Lobby({Key? key}) : super(key: key);

  final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    Get.put(LobbyController());


    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: SafeArea(
        bottom: false,
        child:
        SearchBar<Post>(
          searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
          headerPadding: const EdgeInsets.symmetric(horizontal: 10),
          listPadding: const EdgeInsets.symmetric(horizontal: 10),

          debounceDuration: const Duration(milliseconds: 1000), // 1초후 검색이 실행되게 함
          minimumChars: 2,
          onSearch: controller.getALlPosts,
          searchBarController: controller.searchBarController,
          cancellationWidget: const Text("취소"),
          placeHolder: const Center(child: Text("이미지를 검색하여 주세요")),
          emptyWidget: const Center(child: Text("비어있음")),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),

          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post? post, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(post?.title ?? 'fail' ),
                isThreeLine: true,
                subtitle: Text(post?.body ?? 'fail'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),

      ),
    );

  }
}
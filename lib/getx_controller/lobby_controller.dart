import 'dart:math';

import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:get/get.dart';

import '../model/Post.dart';

class LobbyController extends GetxController {

  // final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');

  final SearchBarController<Post> searchBarController = SearchBarController();
  bool isReplay = false;


  Future<List<Post>> getALlPosts(String? text) async {
    await Future.delayed(Duration(seconds: text?.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text?.length == 5) throw Error();
    if (text?.length == 6) return [];
    List<Post> posts = [];

    var random = Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

}
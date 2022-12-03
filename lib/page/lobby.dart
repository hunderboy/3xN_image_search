import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:flutter/material.dart';

import 'model/Post.dart';


class Lobby extends StatelessWidget {
  Lobby({Key? key}) : super(key: key);

  final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: SafeArea(
        bottom: false,
        child:
        SearchBar<Post>(
          debounceDuration: Duration(milliseconds: 1000),
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          // debounceDuration:1000,
          searchBarController: _searchBarController,
          cancellationWidget: Text("Cancel"),
          placeHolder: Center(child: Text("placeholder")),
          emptyWidget: Center(child: Text("empty")),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),

          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(post.title),
                isThreeLine: true,
                subtitle: Text(post.body),
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
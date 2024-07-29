import 'package:assignment_brandi/search_bar/flappy_search_bar_ns.dart';
import 'package:flutter/material.dart';

import '../model/attendee.dart';
import '../widget/attendee_item.dart';
// custom_serche




class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class SearchBarTestView extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<SearchBarTestView> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;

  List<Post> fooList = [
    Post('one', '1'),
    Post('two', '2'),
    Post('three', '3'),
    Post('four', '4'),
    Post('five', '5')
  ];

  Future<List<Post>> _getALlPosts(String? text) async {
    List<Post> posts = fooList
        .where((element) =>
    element.title.contains(text ?? "fi") || element.body.contains(text ?? "5"))
        .toList();
    return posts;
  }

  /// --------------------------------------------


  /// 수강생 선택
  List<Attendee> connectedAttendeeList = [
    Attendee(profileIMG: "https://e-ga.com.au/cms/wp-content/uploads/2014/03/josh-profile-img1.jpg", nickName: "tomBoy"),
    Attendee(profileIMG: "https://e-ga.com.au/cms/wp-content/uploads/2014/03/josh-profile-img1.jpg", nickName: "tonyKas"),
    Attendee(profileIMG: "https://e-ga.com.au/cms/wp-content/uploads/2014/03/josh-profile-img1.jpg", nickName: "MacCity"),
    Attendee(profileIMG: "https://e-ga.com.au/cms/wp-content/uploads/2014/03/josh-profile-img1.jpg", nickName: "ManUtd"),
    Attendee(profileIMG: "https://e-ga.com.au/cms/wp-content/uploads/2014/03/josh-profile-img1.jpg", nickName: "tottenham"),
  ];
  List<Attendee> inLessonAttendeeList = [
    Attendee(profileIMG: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmZcBdCZpur5u09cgGSBgqcL5cPF4wWa6vug&usqp=CAU", nickName: "indianMan"),
    Attendee(profileIMG: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmZcBdCZpur5u09cgGSBgqcL5cPF4wWa6vug&usqp=CAU", nickName: "indianMan"),
    Attendee(profileIMG: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmZcBdCZpur5u09cgGSBgqcL5cPF4wWa6vug&usqp=CAU", nickName: "indianMan"),
    Attendee(profileIMG: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmZcBdCZpur5u09cgGSBgqcL5cPF4wWa6vug&usqp=CAU", nickName: "indianMan"),
    Attendee(profileIMG: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmZcBdCZpur5u09cgGSBgqcL5cPF4wWa6vug&usqp=CAU", nickName: "indianMan"),
  ];

  /// 검색창 컨트롤러 설정
  final SearchBarController<Attendee> attendeeSearchBarController = SearchBarController();
  /// Future : 이미지 검색
  Future<List<Attendee>> getSearchedImages(String? searchingText) async {
    List<Attendee> attendees = connectedAttendeeList
        .where((element) =>
        element.nickName.contains(searchingText ?? "fi"))
        .toList();
    return attendees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF1F3),
      body: SafeArea(
        child:




        // SearchBar<Post>(
        //   minimumChars: 1,
        //   searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        //   headerPadding: EdgeInsets.symmetric(horizontal: 10),
        //   listPadding: EdgeInsets.symmetric(horizontal: 10),
        //   onSearch: _getALlPosts,
        //   searchBarController: _searchBarController,
        //   placeHolder: const Center(
        //       child: Text(
        //         "PlaceHolder",
        //         style: TextStyle(fontSize: 30),
        //       )),
        //   cancellationWidget: const Text("Cancel"),
        //   emptyWidget: const Text("empty"),
        //   onCancelled: () {
        //     print("Cancelled triggered");
        //   },
        //   mainAxisSpacing: 10,
        //   onItemFound: (Post? post, int index) {
        //     return Container(
        //       color: Colors.lightBlue,
        //       child: ListTile(
        //         title: Text(post?.title ?? "df"),
        //         isThreeLine: true,
        //         subtitle: Text(post?.body ?? "asasasasa"),
        //         onTap: () {
        //           Navigator.of(context)
        //               .push(MaterialPageRoute(builder: (context) => Detail()));
        //         },
        //       ),
        //     );
        //   },
        // ),

        SearchBarCS<Attendee>(
          minimumChars: 1,
          searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
          headerPadding: const EdgeInsets.symmetric(horizontal: 10),
          listPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onSearch: getSearchedImages,
          searchBarController: attendeeSearchBarController,
          hintText: "닉네임을 입력해주세요!",
          hintStyle: const TextStyle(fontSize: 15, color: Color(0xff999999), fontWeight: FontWeight.w400),
          placeHolder: const Center(
              child: Text(
                "PlaceHolder",
                style: TextStyle(fontSize: 30),
              )),
          cancellationWidget: const Text("Cancel"),
          emptyWidget: const Text("empty"),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          onItemFound: (Attendee? attendee, int index) {

            return AttendeeItem(
              profileIMG: attendee?.profileIMG ?? "empty",
              nickName: attendee?.nickName ?? "empty",
            );

          },
        ),

      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
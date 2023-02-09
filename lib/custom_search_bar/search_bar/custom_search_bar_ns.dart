import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'scaled_tile.dart';
import 'search_bar_style.dart';
import 'staggered_grid_view/src/widgets/staggered_grid_view.dart';


/// 검색바 상태
mixin _ControllerListener<T> on State<SearchBar<T>> {
  void onListChanged(List<T> items) {}

  void onLoading() {}

  void onClear() {}

  void onError(Error error) {}
}




// ----------------------------------------------------------------------------------------------------------------
// Controller
class SearchBarController<T> {
  final List<T> _list = [];
  final List<T> _filteredList = [];
  final List<T> _sortedList = [];
  late TextEditingController _searchQueryController;
  String? _lastSearchedText;
  Future<List<T>> Function(String? text)? _lastSearchFunction;
  _ControllerListener? _controllerListener;
  int Function(T a, T b)? _lastSorting;
  CancelableOperation? _cancelableOperation;
  late int minimumChars;

  void setTextController(
    TextEditingController searchQueryController, minimunChars) {
    _searchQueryController = searchQueryController;
    minimumChars = minimunChars;
  }

  void setListener(_ControllerListener _controllerListener) {
    this._controllerListener = _controllerListener;
  }

  void clear() {
    _controllerListener?.onClear();
  }

  void _search(
      String? text,
      Future<List<T>> Function(String? text) onSearch
  ) async {
    _controllerListener?.onLoading();
    try {
      if (_cancelableOperation != null &&
          (!_cancelableOperation!.isCompleted ||
              !_cancelableOperation!.isCanceled)) {
        _cancelableOperation!.cancel();
      }
      _cancelableOperation = CancelableOperation.fromFuture(
        onSearch(text),
        onCancel: () => {},
      );

      final List<T> items = await (_cancelableOperation?.value);
      _lastSearchFunction = onSearch;
      _lastSearchedText = text;
      _list.clear();
      _filteredList.clear();
      _sortedList.clear();
      _lastSorting = null;
      _list.addAll(items);
      _controllerListener?.onListChanged(_list);
    } catch (error) {
      _controllerListener?.onError(error as Error);
    }
  }

  void injectSearch(
      String searchText, Future<List<T>> Function(String? text) onSearch) {
    if (searchText != null && searchText.length >= minimumChars) {
      _searchQueryController.text = searchText;
      _search(searchText, onSearch);
    }
  }

  void replayLastSearch() {
    if (_lastSearchFunction != null && _lastSearchedText != null) {
      _search(_lastSearchedText, _lastSearchFunction!);
    }
  }

  void removeFilter() {
    _filteredList.clear();
    if (_lastSorting == null) {
      _controllerListener?.onListChanged(_list);
    } else {
      _sortedList.clear();
      _sortedList.addAll(List<T>.from(_list));
      _sortedList.sort(_lastSorting);
      _controllerListener?.onListChanged(_sortedList);
    }
  }

  void removeSort() {
    _sortedList.clear();
    _lastSorting = null;
    _controllerListener
        ?.onListChanged(_filteredList.isEmpty ? _list : _filteredList);
  }

  void sortList(int Function(T a, T b) sorting) {
    _lastSorting = sorting;
    _sortedList.clear();
    _sortedList
        .addAll(List<T>.from(_filteredList.isEmpty ? _list : _filteredList));
    _sortedList.sort(sorting);
    _controllerListener?.onListChanged(_sortedList);
  }

  void filterList(bool Function(T item) filter) {
    _filteredList.clear();
    _filteredList.addAll(_sortedList.isEmpty
        ? _list.where(filter).toList()
        : _sortedList.where(filter).toList());
    _controllerListener?.onListChanged(_filteredList);
  }
}



// ----------------------------------------------------------------------------------------------------------------

/// Signature for a function that creates [ScaledTile] for a given index.
typedef ScaledTile IndexedScaledTileBuilder(int index);


class SearchBar<T> extends StatefulWidget {
  /// Future returning searched items
  final Future<List<T>> Function(String? text) onSearch;

  /// List of items showed by default
  final List<T> suggestions;

  /// Callback returning the widget corresponding to a Suggestion item
  final Widget Function(T? item, int index)? buildSuggestion;

  /// Minimum number of chars required for a search
  final int minimumChars;

  /// 검색어 최대 문자열
  final int maximumChars;

  /// Callback returning the widget corresponding to an item found
  final Widget Function(T? item, int index) onItemFound;

  /// Callback returning the widget corresponding to an Error while searching
  final Widget Function(Error error)? onError;

  /// Cooldown between each call to avoid too many
  final Duration debounceDuration;

  /// Widget to show when loading
  final Widget loader;

  /// Widget to show when no item were found
  final Widget emptyWidget;

  /// Widget to show by default
  final Widget? placeHolder;

  /// Widget showed on left of the search bar
  final Widget icon;

  /// Widget placed between the search bar and the results
  final Widget? header;

  /// Hint text of the search bar
  final String hintText;

  /// TextStyle of the hint text
  final TextStyle hintStyle;

  /// Color of the icon when search bar is active
  final Color iconActiveColor;

  /// Text style of the text in the search bar
  final TextStyle textStyle;

  /// Widget shown for cancellation
  final Widget cancellationWidget;

  /// Callback when cancel button is triggered
  final VoidCallback? onCancelled;

  /// Controller used to be able to sort, filter or replay the search
  final SearchBarController? searchBarController;

  /// Enable to edit the style of the search bar
  final SearchBarStyle searchBarStyle;

  /// Number of items displayed on cross axis
  final int crossAxisCount;

  /// Weather the list should take the minimum place or not
  final bool shrinkWrap;

  /// Called to get the tile at the specified index for the
  /// [SliverGridStaggeredTileLayout].
  final IndexedScaledTileBuilder? indexedScaledTileBuilder;

  /// Set the scrollDirection
  final Axis scrollDirection;

  /// Spacing between tiles on main axis
  final double mainAxisSpacing;

  /// Spacing between tiles on cross axis
  final double crossAxisSpacing;

  /// Set a padding on the search bar
  final EdgeInsetsGeometry searchBarPadding;

  /// Set a padding on the header
  final EdgeInsetsGeometry headerPadding;

  /// Set a padding on the list
  final EdgeInsetsGeometry listPadding;

  SearchBar({
    Key? key,
    required this.onSearch,
    required this.onItemFound,
    this.searchBarController,
    this.minimumChars = 2,  // 최소 검색어 수
    this.maximumChars = 10, // 최대 검색어 수
    this.debounceDuration = const Duration(milliseconds: 500),
    this.loader = const Center(child: CircularProgressIndicator()),
    this.onError,
    this.emptyWidget = const SizedBox.shrink(),
    this.header,
    this.placeHolder,
    this.icon = const Icon(Icons.search),
    this.hintText = "",
    this.hintStyle = const TextStyle(color: Color.fromRGBO(142, 142, 147, 1)),
    this.iconActiveColor = Colors.black,
    this.textStyle = const TextStyle(color: Colors.black),
    this.cancellationWidget = const Text("Cancel"),
    this.onCancelled,
    this.suggestions = const [],
    this.buildSuggestion,
    this.searchBarStyle = const SearchBarStyle(),
    this.crossAxisCount = 1,
    this.shrinkWrap = false,
    this.indexedScaledTileBuilder,
    this.scrollDirection = Axis.vertical,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.listPadding = const EdgeInsets.all(0),
    this.searchBarPadding = const EdgeInsets.all(0),
    this.headerPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState<T>();
}


class _SearchBarState<T> extends State<SearchBar<T?>> with TickerProviderStateMixin, _ControllerListener<T?> {
  bool _loading = false; // 로딩중?
  Widget? _error; // 에러 발생시 표현할 위젯 todo : 에러 위젯은 따로 만들고, 에러 이벤트 변수를 만드는게 나을듯
  final _searchQueryController = TextEditingController(); // 텍스트 변화 감지 컨트롤러
  Timer? _debounce;   // 검색단어 작성 완료 후 몇초뒤에 실행 할건지?
  bool _animate = false;  // 애니메이션 이벤트 변수
  List<T?> _list = [];    // 데이터 리스트
  late SearchBarController searchBarController; // 위젯을 생성하면서 검색창 컨트롤러 생성
  String previousSearchText = ""; // 이전 검색어



// @override 함수 ----------------------------------------------------------------------------------------------------------------
  /// 초기화
  @override
  void initState() {
    super.initState();
    searchBarController = widget.searchBarController ?? SearchBarController<T>();
    searchBarController.setListener(this);
    searchBarController.setTextController(_searchQueryController, widget.minimumChars);
  }

  @override
  void onListChanged(List<T?> items) {
    setState(() {
      _loading = false;
      _list = items;
    });
  }

  @override
  void onLoading() {
    setState(() {
      _loading = true;
      _error = null;
      _animate = true;
    });
  }

  @override
  void onClear() {
    _cancel();
  }

  /// 에러처리
  @override
  void onError(Error error) {
    setState(() {
      _loading = false;
      _error = widget.onError != null ? widget.onError!(error) : const Center(child: Text("에러가 발생하였습니다.\n다시 시도하여 주세요."));
    });
  }



// 커스텀 함수 ----------------------------------------------------------------------------------------------------------------
  /// 텍스트 변화 감지
  _onTextChanged(String newText) async {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Timer(몇초뒤에 실핼할건가?, 실행할 함수)
    _debounce = Timer(widget.debounceDuration, () async {
      /// 검색단어 앞뒤 공백 제거
      // print('newText : $newText, 길이 : ${newText.length}');
      String trimed_text = newText.trim();
      // print('after trim : $trimed_text, 길이 : ${trimed_text.length}');

      /// 스페이스 바 는 어떻게 처리할 것인가?
      if(trimed_text.isEmpty){
        // do nothing
      }
      else if(trimed_text == previousSearchText){
        // do nothing
        // // 이전 검색어와 같을 경우 = 중복 검색 방지
      }
      // 글자수 1개인 경우
      else if(trimed_text.length < widget.minimumChars){
        // Singleton().showToast("글자수 2개 이상 적어 주세요");
      }
      // 글자수 11개 이상인 경우
      else if(trimed_text.length > widget.maximumChars){
        // Singleton().showToast("글자수 10개 이하로 적어 주세요");
      }
      else if (trimed_text.length >= widget.minimumChars) {
        previousSearchText = trimed_text;
        searchBarController._search(trimed_text, widget.onSearch); // 검색 실행
      } else {
        setState(() {
          _list.clear();
          _error = null;
          _loading = false;
          _animate = false;
        });
      }
    });
  }

  /// 취소
  void _cancel() {
    if (widget.onCancelled != null) {
      widget.onCancelled!();
    }

    setState(() {
      _searchQueryController.clear();
      _list.clear();
      _error = null;
      _loading = false;
      _animate = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    final widthMax = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: widget.searchBarPadding,
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /// 검색창
                Flexible(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _animate ? widthMax * .8 : widthMax,
                    decoration: BoxDecoration(
                      borderRadius: widget.searchBarStyle.borderRadius,
                      color: widget.searchBarStyle.backgroundColor,
                    ),
                    child: Padding(
                      padding: widget.searchBarStyle.padding,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: widget.iconActiveColor,
                        ),
                        child: TextField(
                          controller: _searchQueryController,
                          onChanged: _onTextChanged,
                          style: widget.textStyle,
                          decoration: InputDecoration(
                            icon: widget.icon,
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            hintStyle: widget.hintStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                /// 취소 버튼
                GestureDetector(
                  onTap: _cancel,
                  child: AnimatedOpacity(
                    opacity: _animate ? 1.0 : 0,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: _animate ? 1000 : 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width:
                          _animate ? MediaQuery.of(context).size.width * .2 : 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: widget.cancellationWidget,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded( // 리스트
          child: _buildContent(context)!,
        ),
      ],
    );
  }

  Widget? _buildContent(BuildContext context) {
    // 1. 에러
    if (_error != null) {
      return _error;
    }
    // 2. 로딩중
    else if (_loading) {
      return widget.loader;
    }
    // 3. 검색어 문자수 < 최소 문자수
    else if (_searchQueryController.text.length < widget.minimumChars) {
      // 3-1. placeHolder 가 null 이 아닌 경우
      if (widget.placeHolder != null) {
        return widget.placeHolder;
      }
      // 3-2. 리스트 빌드
      return _buildListView(widget.suggestions, widget.buildSuggestion ?? widget.onItemFound);
    }
    // 4. 리스트가 비어있지 않은 경우
    else if (_list.isNotEmpty) {
      return _buildListView(_list, widget.onItemFound);
    }
    // 5. 그외의 모든 상황 = emptyWidget 표시
    else {
      return widget.emptyWidget;
    }
  }

  Widget _buildListView(
      List<T?> items,
      Widget Function(T? item, int index) builder
  ) {
    return Padding(
      padding: widget.listPadding,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: widget.crossAxisCount,
        itemCount: items.length,
        shrinkWrap: widget.shrinkWrap,
        staggeredTileBuilder: widget.indexedScaledTileBuilder ??
            ((int index) => ScaledTile.fit(1)),
        scrollDirection: widget.scrollDirection,
        mainAxisSpacing: widget.mainAxisSpacing,
        crossAxisSpacing: widget.crossAxisSpacing,
        addAutomaticKeepAlives: true,
        itemBuilder: (BuildContext context, int index) {
          return builder(items[index], index);
        },
      ),
    );

    // return Padding(
    //     padding: widget.listPadding,
    //     child:
    //     // ListView.builder(
    //     //   itemCount: items.length,
    //     //   scrollDirection: Axis.vertical,
    //     //   padding: const EdgeInsets.symmetric(horizontal: 12), // 리스트 양쪽 끝 부분 padding 적용
    //     //   itemBuilder: (context, index) {
    //     //     // return CategoryItem(index: index, lessonTagStr: controller.categoryList[index]);
    //     //     return builder(items[index], index);
    //     //   },
    //     // ),
    //     // GridView.builder( /// 1줄에 3개 보여주는 GridView 설정
    //     //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     //       crossAxisCount: 3,        // 1 개의 행에 보여줄 item 개수
    //     //       childAspectRatio: 1/1,    // item 의 가로 1, 세로 2 의 비율 (기본은 1대1 비뮬)
    //     //       mainAxisSpacing: 10,      // item 간의 수직 Padding
    //     //       crossAxisSpacing: 14,     // item 간의 수평 Padding
    //     //     ),
    //     //     itemCount: items.length,
    //     //     itemBuilder: (context, index) {
    //     //       return builder(items[index], index);
    //     //       // return ImageTile(
    //     //       //   // title: deduplicatedList[index].name,
    //     //       //   title : "텍스트"
    //     //       // );
    //     //     }
    //     // )
    // );
  }



}

// ignore_for_file: slash_for_doc_comments
import 'dart:async';



class CountBloc {

  int _count = 0;
  /**
      Single-subscription Streams
      Stream의 lifetime(생명주기) 동안 한 개의 Listener만 허용합니다.
      해당 Stream에서는 첫 번째 Subscription object에서 구독이 취소되어도 재 구독이 불가능합니다.
   */
  final StreamController<int> _countSubject = StreamController<int>();
  /**
      Broadcast Streams
      여러개의 Listener를 허용합니다.
      어느 시점이던 Boradcast Stream에 Listener를 추가할 수 있습니다. 새로운 Listener는 listening을 시작하는 순간부터 events들을 받게 됩니다.
   */
  /// final StreamController<int> _countSubject = StreamController<int>.broadcast();
  Stream<int> get count => _countSubject.stream;


  add() {
    _count++;
    _countSubject.sink.add(_count); // Sink 진입점
  }


  dispose() {
    _countSubject.close();
  }

}

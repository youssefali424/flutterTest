import 'dart:async';

class PaginatedStream<T> extends Stream<T> {
  final StreamController<T> streamController =
      StreamController<T>.broadcast(sync: true);
  

  @override
  StreamSubscription<T> listen(
    void onData(T event), {
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) {
    if (streamController.onCancel == null) {
      streamController.onCancel = () {
        streamController.close();
      };
    }

    return streamController.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
  
}

import 'dart:async';

abstract class AppBloc {
  final List<StreamSubscription> streamSubscriptions = [];

  void addSubscription(StreamSubscription<dynamic> subscription) {
    streamSubscriptions.add(subscription);
  }

  void dispose() {
    for (final subscription in streamSubscriptions) {
      subscription.cancel();
    }
    streamSubscriptions.clear();
  }
}

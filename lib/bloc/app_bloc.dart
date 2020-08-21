import 'dart:async';

abstract class AppBloc {
  final List<StreamSubscription> streamSubscriptions = [];

  void addSubscription(StreamSubscription<dynamic> subscription) {
    streamSubscriptions.add(subscription);
  }

  void dispose() {
    streamSubscriptions.forEach((subscription) => subscription.cancel());
    streamSubscriptions.clear();
  }
}

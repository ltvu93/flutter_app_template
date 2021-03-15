import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/domain/global_loading_manager.dart';
import 'package:provider/provider.dart';

late BuildContext _appContext;

void init(BuildContext context) => _appContext = context;

abstract class AppBloc {
  final globalLoadingManager = _appContext.read<GlobalLoadingManager>();

  final List<StreamSubscription> streamSubscriptions = [];

  void addSubscription(StreamSubscription<dynamic> subscription) {
    streamSubscriptions.add(subscription);
  }

  @protected
  @mustCallSuper
  void dispose() {
    for (final subscription in streamSubscriptions) {
      subscription.cancel();
    }
    streamSubscriptions.clear();
  }
}

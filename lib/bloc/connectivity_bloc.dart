import 'package:connectivity/connectivity.dart';
import 'package:flutter_app_template/bloc/app_bloc.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:rxdart/rxdart.dart';

enum NetworkStatus {
  mobile,
  wifi,
  offline,
}

class ConnectivityBloc extends AppBloc {
  final networkStatusSubject = BehaviorSubject<NetworkStatus>.seeded(NetworkStatus.offline);

  ConnectivityBloc(DialogManager dialogManager) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      final networkStatus = _getNetworkStatusFromResult(result);

      networkStatusSubject.add(networkStatus);

      if (networkStatus == NetworkStatus.offline) {
        dialogManager.showAlert('Network error', 'You are offline!!!');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    networkStatusSubject.close();
  }

  NetworkStatus _getNetworkStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return NetworkStatus.wifi;
      case ConnectivityResult.mobile:
        return NetworkStatus.mobile;
      case ConnectivityResult.none:
        return NetworkStatus.offline;
      default:
        return NetworkStatus.offline;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_template/models/api_error.dart';

class DialogManager {
  final GlobalKey<NavigatorState> _navigatorKey;
  bool _isLoadingDialogShowing = false;

  DialogManager(this._navigatorKey);

  Future<void> showError(ApiError error) async {
    await showDialog(
      context: _navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_getErrorMessage(error)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  String _getErrorMessage(ApiError apiError) {
    switch (apiError.runtimeType) {
      case UnknownError:
        return 'Some thing went wrong. Please try again!';
      case NetworkTimeoutError:
        return 'Connection time out.';
      case ServerError:
        return (apiError as ServerError).firstError ?? '';
      default:
        throw Exception("Don't support this type $apiError");
    }
  }

  Future<void> showLoading() async {
    _isLoadingDialogShowing = true;

    await showDialog(
      context: _navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void hideLoading() {
    if (_isLoadingDialogShowing) {
      _navigatorKey.currentState.pop();
      _isLoadingDialogShowing = false;
    }
  }

  Future<void> showAlert(String title, String message) async {
    await showDialog(
      context: _navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_template/data/remote/user_service.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/screens/change_language_screen.dart';
import 'package:flutter_app_template/screens/home_screen.dart';
import 'package:flutter_app_template/screens/load_more_screen.dart';
import 'package:flutter_app_template/screens/setting_screen.dart';
import 'package:provider/provider.dart';

class ScreenNavigator {
  final GlobalKey<NavigatorState> _navigatorKey;

  ScreenNavigator(this._navigatorKey);

  void goToHomeScreen() {
    _navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void goToSettingScreen(String settingId) {
    _navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => SettingScreen(
          settingId: settingId,
        ),
      ),
    );
  }

  void goToLoadMoreScreen() {
    _navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => Provider<LoadMoreBloc>(
          create: (context) => LoadMoreBloc(
            context.read<ScreenNavigator>(),
            context.read<DialogManager>(),
            context.read<UserService>(),
          ),
          dispose: (_, loadMoreBloc) => loadMoreBloc.dispose(),
          child: LoadMoreScreen(),
        ),
      ),
    );
  }

  void goToChangeLanguageScreen() {
    _navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => ChangeLanguageScreen(),
      ),
    );
  }

  void goBack() {
    _navigatorKey.currentState.pop();
  }
}

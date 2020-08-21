import 'package:flutter/material.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/l10n_manual/app_localizations.dart';
import 'package:flutter_app_template/l10n_manual/text_keys.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<DialogManager>().showError(UnknownError());
              },
              child: Text('Show Error'),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                context.read<ScreenNavigator>().goToSettingScreen('John Done');
              },
              child: Text('Go to Setting'),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<ScreenNavigator>().goToLoadMoreScreen();
              },
              child: Text('Go to load more'),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<ScreenNavigator>().goToChangeLanguageScreen();
              },
              child: Text('Change language'),
            ),
          ],
        ),
      ),
    );
  }
}

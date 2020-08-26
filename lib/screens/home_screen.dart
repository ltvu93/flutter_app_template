import 'package:flutter/material.dart';
import 'package:flutter_app_template/data/local/token_storage.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<DialogManager>().showError(UnknownError());
              },
              child: const Text('Show Error'),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                context.read<ScreenNavigator>().goToSettingScreen('John Done');
              },
              child: const Text('Go to Setting'),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<ScreenNavigator>().goToLoadMoreScreen();
              },
              child: const Text('Go to load more'),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                context.read<ScreenNavigator>().goToChangeLanguageScreen();
              },
              child: const Text('Change language'),
            ),
            RaisedButton(
              onPressed: () async {
                await context.read<TokenStorage>().clear();
                context.read<ScreenNavigator>().goToLoginScreen();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  final String settingId;

  const SettingScreen({required this.settingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Screen $settingId'),
      ),
      body: SafeArea(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              Provider.of(context)<ScreenNavigator>().goBack();
            },
            child: const Text('Back'),
          ),
        ),
      ),
    );
  }
}

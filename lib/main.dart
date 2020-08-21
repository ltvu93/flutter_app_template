import 'package:flutter/material.dart';
import 'package:flutter_app_template/app_config.dart';
import 'package:flutter_app_template/bloc/connectivity_bloc.dart';
import 'package:flutter_app_template/data/remote/app_dio.dart';
import 'package:flutter_app_template/data/remote/user_service.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/generated/l10n.dart';
import 'package:flutter_app_template/l10n_manual/locale_manager.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:flutter_app_template/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  AppConfig.build(Environment.dev);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleManager>(
          create: (_) => LocaleManager(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ScreenNavigator>(
          create: (_) => ScreenNavigator(_navigatorKey),
        ),
        Provider<DialogManager>(
          create: (_) => DialogManager(_navigatorKey),
        ),
        Provider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(
            context.read<DialogManager>(),
          ),
        ),
        Provider<AppDio>(
          create: (_) => AppDio(),
        ),
        Provider<UserService>(
          create: (context) => UserService(context.read<AppDio>()),
        ),
      ],
      child: Consumer<LocaleManager>(
        builder: (_, localeManager, __) {
          return MaterialApp(
            locale: localeManager.locale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            navigatorKey: _navigatorKey,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Provider<LoginBloc>(
              create: (context) => LoginBloc(
                context.read<ScreenNavigator>(),
                context.read<DialogManager>(),
                context.read<UserService>(),
              ),
              dispose: (_, loginBloc) => loginBloc.dispose(),
              child: LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}

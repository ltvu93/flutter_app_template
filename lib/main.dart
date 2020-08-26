import 'package:flutter/material.dart';
import 'package:flutter_app_template/app_config.dart';
import 'package:flutter_app_template/bloc/connectivity_bloc.dart';
import 'package:flutter_app_template/data/local/token_storage.dart';
import 'package:flutter_app_template/data/remote/app_dio.dart';
import 'package:flutter_app_template/data/remote/user_service.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/generated/l10n.dart';
import 'package:flutter_app_template/l10n_manual/locale_manager.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/models/user.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:flutter_app_template/screens/home_screen.dart';
import 'package:flutter_app_template/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.build(Environment.dev);

  runApp(MyApp());
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
        Provider<TokenStorage>(
          create: (_) => TokenStorage(),
        ),
        Provider<AppDio>(
          create: (context) => AppDio(context.read<TokenStorage>()),
        ),
        Provider<UserService>(
          create: (context) => UserService(context.read<AppDio>()),
        ),
        ChangeNotifierProvider<LocaleManager>(
          create: (_) => LocaleManager(),
        ),
        ChangeNotifierProvider<AuthenticateManager>(
          create: (context) => AuthenticateManager(
            context.read<UserService>(),
          ),
        ),
      ],
      child: Consumer<LocaleManager>(
        builder: (_, localeManager, __) {
          return MaterialApp(
            locale: localeManager.locale,
            localizationsDelegates: const [
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
            home: AuthenticateGuard(),
          );
        },
      ),
    );
  }
}

class AuthenticateGuard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticateManager>(
      builder: (_, authenticateManager, __) {
        if (authenticateManager.isLoading) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (authenticateManager.isAuthenticated) {
            return HomeScreen();
          } else {
            return LoginScreen.content();
          }
        }
      },
    );
  }
}

class AuthenticateManager extends ChangeNotifier {
  UserService userService;

  bool isLoading;
  User user;

  bool get isAuthenticated => user != null;

  AuthenticateManager(this.userService) {
    authenticate();
  }

  Future<void> authenticate() async {
    try {
      isLoading = true;
      user = await userService.getUser();
    } on UnAuthenticateError {
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

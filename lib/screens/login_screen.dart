import 'package:flutter/material.dart';
import 'package:flutter_app_template/bloc/app_bloc.dart';
import 'package:flutter_app_template/data/local/token_storage.dart';
import 'package:flutter_app_template/data/remote/user_service.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/generated/l10n.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:flutter_app_template/validator.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreen extends StatefulWidget {
  static Widget content() {
    return Provider<LoginBloc>(
      create: (context) => LoginBloc(
        context.read<ScreenNavigator>(),
        context.read<DialogManager>(),
        context.read<UserService>(),
        context.read<TokenStorage>(),
      ),
      dispose: (_, loginBloc) => loginBloc.dispose(),
      child: LoginScreen(),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    emailTextController.addListener(() {
      context.read<LoginBloc>().emailInputSubject.add(emailTextController.text);
    });
    passwordTextController.addListener(() {
      context
          .read<LoginBloc>()
          .passwordInputSubject
          .add(passwordTextController.text);
    });

    emailTextController.text = 'example@gmail.com';
    passwordTextController.text = 'password123';
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();

    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreamBuilder<ValidateError>(
                stream: context.watch<LoginBloc>().emailValidateError,
                builder: (context, snapshot) {
                  final error = snapshot.data ?? ValidateError.none;

                  return TextField(
                    controller: emailTextController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: error.getMessage(
                        S.of(context),
                        S.of(context).email,
                      ),
                    ),
                    onSubmitted: (_) => passwordFocus.requestFocus(),
                  );
                },
              ),
              StreamBuilder<ValidateError>(
                stream: context.watch<LoginBloc>().passwordValidateError,
                builder: (context, snapshot) {
                  final error = snapshot.data ?? ValidateError.none;

                  return TextField(
                    controller: passwordTextController,
                    focusNode: passwordFocus,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: error.getMessage(
                        S.of(context),
                        S.of(context).password,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              StreamBuilder<bool>(
                stream: context.watch<LoginBloc>().isAllValidated,
                builder: (_, snapshot) {
                  final isValid = snapshot.data ?? false;

                  return RaisedButton(
                    onPressed: isValid ? _login : null,
                    child: const Text('Login'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    context.read<LoginBloc>()._login(
          emailTextController.text,
          passwordTextController.text,
        );
  }
}

class LoginBloc extends AppBloc {
  final ScreenNavigator screenNavigator;
  final DialogManager dialogManager;

  final UserService userService;
  final TokenStorage tokenStorage;

  final emailInputSubject = BehaviorSubject<String>();
  final passwordInputSubject = BehaviorSubject<String>();

  Stream<ValidateError> get emailValidateError => emailInputSubject.stream.map(
        (email) => Validator.email(email),
      );

  Stream<ValidateError> get passwordValidateError =>
      passwordInputSubject.stream.map(
        (password) => Validator.password(password),
      );

  Stream<bool> get isAllValidated => Rx.combineLatest2(
        emailValidateError,
        passwordValidateError,
        (
          ValidateError emailError,
          ValidateError passwordError,
        ) =>
            emailError.isNone && passwordError.isNone,
      );

  LoginBloc(
    this.screenNavigator,
    this.dialogManager,
    this.userService,
    this.tokenStorage,
  );

  @override
  void dispose() {
    emailInputSubject.close();
    passwordInputSubject.close();

    super.dispose();
  }

  Future<void> _login(String userName, String password) async {
    try {
      globalLoadingManager.show();

      final token = await userService.login(userName, password);
      await tokenStorage.saveToken(token);
      final user = await userService.getUser();

      screenNavigator.goToHomeScreen();
    } on ApiError catch (error) {
      dialogManager.showError(error);
    } finally {
      globalLoadingManager.hide();
    }
  }
}

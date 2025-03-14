import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/sessionDataProvider.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';

class AuthModel extends ChangeNotifier {
  final api_Client = api_client();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _canAuth = true;
  bool get canAuth => _canAuth;
  bool get authInProcces => !_canAuth;

  Future<void> auth(BuildContext context) async {
    final login = emailController.text;
    final password = passwordController.text;
    int? accountId;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = "Заповніть поля";
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _canAuth = false;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await api_Client.auth(login: login, password: password);
      accountId = await api_Client.getAccoutData(sessionId);

      _canAuth = true;
      notifyListeners();

      _canAuth = true;
      notifyListeners();

      // Перевіряємо, чи компонент ще змонтований у контексті
    } on ApiClientErrors catch (e) {
      switch (e.type) {
        case ApiClientExpeptionType.Network:
          _errorMessage = "Сервер недоступний";
        case ApiClientExpeptionType.Auth:
          _errorMessage = "Неправильний логін або пароль";
        case ApiClientExpeptionType.Other:
          _errorMessage = "Сталася помилка спробуйте ще раз";
      }
    }
    notifyListeners();
    if (sessionId == null || accountId == null) {
      notifyListeners();
      return;
    }
    await Sessiondataprovider().setSession(sessionId);
    await Sessiondataprovider().setAccountId(accountId);
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(MainNavRoutes.mainScreen);
    }
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;
//   final Widget child;
//   const AuthProvider({
//     super.key,
//     required this.model,
//     required this.child,
//   }) : super(child: child, notifier: model);

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget =
//         context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }
// }

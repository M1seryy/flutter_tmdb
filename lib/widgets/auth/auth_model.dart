import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';

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
    print("start");
    final login = emailController.text;
    final password = passwordController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = "Заповніть поля";
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _canAuth = false;
    notifyListeners();
    final sessionId = await api_client().auth(login: login, password: password);
    _canAuth = true;
    notifyListeners();
    print("auth");
    if (context.mounted) {
      Navigator.of(context).push;
    }
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  final Widget child;
  const AuthProvider({
    super.key,
    required this.model,
    required this.child,
  }) : super(child: child, notifier: model);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}

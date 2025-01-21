import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_tmdb/Theme/button_style.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/auth/auth_model.dart';

class Authlogin extends StatelessWidget {
  const Authlogin({super.key});

  @override
  Widget build(BuildContext context) {
    final regularTextStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login your account",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            _AuthInputs(),
            _MainText(regularTextStyle: regularTextStyle),
          ],
        ),
      ),
    );
  }
}

class _AuthInputs extends StatelessWidget {
  _AuthInputs({super.key});

  final inputStyle = const InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8));

  @override
  Widget build(BuildContext context) {
    final model = ModelProvider.read<AuthModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email"),
        TextField(
          controller: model?.emailController,
          decoration: inputStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Password"),
        TextField(
          controller: model?.passwordController,
          obscureText: true,
          decoration: inputStyle,
        ),
        const SizedBox(
          height: 25,
        ),
        const ErrorMessageWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _loginButtonWidget(),
            const SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: null,
                child: Text(
                  "Reset password",
                  style: AppButtonStyle.linkButton,
                ))
          ],
        )
      ],
    );
  }
}

class _loginButtonWidget extends StatelessWidget {
  const _loginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProvider.watch<AuthModel>(context);

    return TextButton(
      onPressed: model?.canAuth == true
          ? () async => await model?.auth(context)
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          model?.canAuth == true ? Colors.blue : Colors.grey,
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = ModelProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MainText extends StatelessWidget {
  const _MainText({
    required this.regularTextStyle,
  });

  final TextStyle regularTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 40,
      ),
      Text(
          " In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.",
          style: regularTextStyle),
      const SizedBox(
        height: 15,
      ),
      TextButton(
          style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
          onPressed: null,
          child: Text(
            "Register",
            style: AppButtonStyle.linkButton,
          )),
      Text(
        "If you signed up but didn't get your verification email, ",
        style: regularTextStyle,
      ),
      TextButton(
          style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
          onPressed: null,
          child: Text(
            "Verify email",
            style: AppButtonStyle.linkButton,
          )),
    ]);
  }
}

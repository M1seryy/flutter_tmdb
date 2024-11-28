import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_tmdb/Theme/button_style.dart';

class Authlogin extends StatelessWidget {
  const Authlogin({super.key});

  @override
  Widget build(BuildContext context) {
    final regularTextStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

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
            SizedBox(
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

class _AuthInputs extends StatefulWidget {
  @override
  State<_AuthInputs> createState() => _AuthInputsState();
}

class _AuthInputsState extends State<_AuthInputs> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  String? errorAuth;

  final inputStyle = const InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8));

  void _authLogin() {
    final login = _emailController.text;
    final pass = _passwordController.text;
    if (login == "admin" && pass == "123456") {
      errorAuth = null;
      print("we are in");
    } else {
      errorAuth = "Incorrect email or password";
      print("error");
    }
    setState(() {});
  }

  void _verifyPass() {
    print("pass verify");
  }

  @override
  Widget build(BuildContext context) {
    final textError = this.errorAuth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email"),
        TextField(
          controller: _emailController,
          decoration: inputStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Password"),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: inputStyle,
        ),
        const SizedBox(
          height: 25,
        ),
        if (textError != null) ...[
          const Center(
              child: Column(
            children: [
              Text(
                "Incorrect email or password",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          )),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                    backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(255, 222, 226, 230))),
                onPressed: _authLogin,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                )),
            const SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: _verifyPass,
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
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
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
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
          onPressed: null,
          child: Text(
            "Verify email",
            style: AppButtonStyle.linkButton,
          )),
    ]);
  }
}

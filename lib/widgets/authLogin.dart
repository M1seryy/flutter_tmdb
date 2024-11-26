import 'package:flutter/material.dart';

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
            _MainText(regularTextStyle: regularTextStyle),
            SizedBox(
              height: 25,
            ),
            _AuthInputs(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                        backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255, 222, 226, 230))),
                    onPressed: null,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthInputs extends StatelessWidget {
  _AuthInputs({
    super.key,
  });
  final inputStyle = InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        TextField(
          decoration: inputStyle,
        ),
        SizedBox(
          height: 20,
        ),
        Text("Password"),
        TextField(
          obscureText: true,
          decoration: inputStyle,
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
    return Column(children: [
      const SizedBox(
        height: 40,
      ),
      Text(
          " In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.",
          style: regularTextStyle),
      const SizedBox(
        height: 25,
      ),
      Text(
        "If you signed up but didn't get your verification email, ",
        style: regularTextStyle,
      )
    ]);
  }
}

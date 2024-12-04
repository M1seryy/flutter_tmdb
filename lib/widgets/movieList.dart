import 'package:flutter/material.dart';

class Movielist extends StatelessWidget {
  const Movielist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Image(
                      image: AssetImage(
                          "https://i.ebayimg.com/images/g/FKsAAOSw8DZgGo2i/s-l400.jpg"))
                ],
              );
            }),
      ),
    );
  }
}

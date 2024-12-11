import 'package:flutter/material.dart';

class Screencast extends StatelessWidget {
  const Screencast({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "Screen Cast",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 1), //----------BAD PRACTICE
                              width: 100,
                              height: 100,
                              child: Image(
                                  image: NetworkImage(
                                      'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQz8wN5zKhYp6mfWv_R7PJeKdR3gLB5PbFe1wTMZwxrG-ZHAhZXkLiNvmv5Zr3Gmd0QBW031BUrJIz6eHMDYCgFH9UBU45jVvsvEQaH0J0')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

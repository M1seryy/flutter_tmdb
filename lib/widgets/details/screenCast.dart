import 'package:flutter/material.dart';

class Screencast extends StatelessWidget {
  const Screencast({super.key});

  @override
  Widget build(BuildContext context) {
    final castTextStyle = TextStyle(fontWeight: FontWeight.w600);

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
            height: 320,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Scrollbar(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemExtent: 120,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 2), //----------BAD PRACTICE
                                  width: 100,
                                  height: 100,
                                  child: Image(
                                      image: NetworkImage(
                                          'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQz8wN5zKhYp6mfWv_R7PJeKdR3gLB5PbFe1wTMZwxrG-ZHAhZXkLiNvmv5Zr3Gmd0QBW031BUrJIz6eHMDYCgFH9UBU45jVvsvEQaH0J0')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          maxLines: 4,
                                          "Steven Young",
                                          style: castTextStyle),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                          maxLines: 4,
                                          "Mark Grayson / Invictable (Voice)",
                                          style: castTextStyle),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                          maxLines: 4,
                                          "8 Episodes",
                                          style: castTextStyle),
                                      SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: TextButton(
                onPressed: null,
                child: Text(
                  "Full cast data",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
          )
        ],
      ),
    );
  }
}

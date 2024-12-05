import 'package:flutter/material.dart';

class Movielist extends StatelessWidget {
  const Movielist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemExtent: 163,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 53, 52, 52).withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(2, 8))
                  ],
                ),
                child: Row(
                  children: [
                    Image(
                        height: 163,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://posterhouse.org/wp-content/uploads/2021/05/moonlight_0.jpg")),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Mortal Kombat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "April 7, 2021",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          "В эпоху Новой Республики группа детей заблудилась в галактике Звёздных войн, пытаясь найти дорогу домой.В эпоху Новой Республики группа детей заблудилась в галактике Звёздных войн, пытаясь найти дорогу домой.",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

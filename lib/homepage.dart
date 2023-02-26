import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Set<String> categories =
    Set<String>.from(list.map((item) => item['Category']));
    uniqueList = categories.map((category) => {'Category': category}).toList();
    print(uniqueList);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Animals around the world",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        titleSpacing: 2,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            children: [
        Expanded(
        child: GridView.count(
        crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            children:uniqueList.map((e) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('List',arguments: e['Category']);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(
                            (Random().nextDouble() * 0xFFFFFF)
                                .toInt())
                            .withOpacity(0.3),
                      ),
                      alignment: Alignment.center,child: Text(
                      "${e['Category']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ),
                  ),
                ),
              ),
            )).toList()
        ),)
        ],
      ),
    ),);
  }
}

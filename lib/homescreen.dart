import 'package:flutter/material.dart';

import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int left = 1;
  int right = 1;
  AnimationController controller;
  var animation;
  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  animate() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation.addListener(() {
      setState(() {});
      print(controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          left = Random().nextInt(6) + 1;
          right = Random().nextInt(6) + 1;
        });

        print(controller.value);
        controller.reverse();
      }
    });
  }

  void roll() {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dice"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      roll();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage('images/dice-png-$left.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      roll();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage('images/dice-png-$right.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: roll,
              child: Text(
                "ROLL",
              ),
            )
          ],
        ),
      ),
    );
  }
}

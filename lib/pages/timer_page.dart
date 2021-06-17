import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const duration = Duration(
    seconds: 1,
  );
  int timeElapsed = 0;
  bool isActive = false;
  Timer timer;

  void handleTime() {
    if (isActive) {
      setState(() {
        timeElapsed = timeElapsed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(
        duration,
        (Timer t) {
          handleTime();
        },
      );
    }
    int seconds = timeElapsed % 60;
    int minutes = (timeElapsed / 60).truncate().toInt();
    int hours = (timeElapsed / 3600).truncate().toInt();
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LookButton(
                  label: 'HRs',
                  color: Colors.pink,
                  value: hours.toString().padLeft(2, '0'),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                LookButton(
                  label: 'MINs',
                  color: Colors.red,
                  value: minutes.toString().padLeft(2, '0'),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                LookButton(
                  label: 'SECs',
                  color: Colors.blueAccent,
                  value: seconds.toString().padLeft(2, '0'),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 50,
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: Colors.purpleAccent.shade100,
                  onPrimary: Colors.blueAccent,
                ),
                child: Text(
                  isActive ? 'STOP' : 'START',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LookButton extends StatelessWidget {
  LookButton({
    this.label,
    this.value,
    this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.shade200,
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontSize: 55,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

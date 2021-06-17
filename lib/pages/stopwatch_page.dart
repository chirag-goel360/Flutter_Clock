import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock/helper/StopWatchTimeClock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  Widget leftButtonIcon;
  Widget rightButtonIcon;
  Color leftButtonColor;
  Color rightButtonColor;
  Timer timer;
  Stopwatch stopwatch = Stopwatch();
  List<String> lapList = [];

  updateTime(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    if (stopwatch.isRunning) {
      timer = Timer.periodic(
        Duration(
          milliseconds: 20,
        ),
        updateTime,
      );
      leftButtonIcon = Icon(
        FontAwesomeIcons.pause,
      );
      leftButtonColor = Colors.red.shade300;
      rightButtonIcon = Icon(
        FontAwesomeIcons.dotCircle,
        color: Colors.purple.shade300,
      );
      rightButtonColor = Colors.white70;
    } else {
      leftButtonIcon = Icon(
        FontAwesomeIcons.play,
      );
      leftButtonColor = Colors.pinkAccent.shade200;
      rightButtonIcon = Icon(
        FontAwesomeIcons.reply,
      );
      rightButtonColor = Colors.blueAccent;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 240.0,
            width: 240.0,
            child: StopWatchClock(
              stopwatch: stopwatch,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: leftButtonColor,
                onPressed: startWatch,
                child: leftButtonIcon,
              ),
              SizedBox(
                width: 20.0,
              ),
              FloatingActionButton(
                backgroundColor: rightButtonColor,
                onPressed: stopWatch,
                child: rightButtonIcon,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lapList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    alignment: Alignment.center,
                    child: Text(
                      listItems(
                        lapList.length,
                        index,
                        lapList.elementAt(index),
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  startWatch() {
    if (stopwatch.isRunning) {
      leftButtonIcon = Icon(
        FontAwesomeIcons.play,
      );
      leftButtonColor = Colors.pinkAccent.shade200;
      rightButtonIcon = Icon(
        FontAwesomeIcons.reply,
      );
      rightButtonColor = Colors.blueAccent;
      stopwatch.stop();
      setState(() {});
    } else {
      leftButtonIcon = Icon(
        FontAwesomeIcons.pause,
      );
      leftButtonColor = Colors.red.shade300;
      rightButtonIcon = Icon(
        FontAwesomeIcons.dotCircle,
        color: Colors.purple.shade300,
      );
      rightButtonColor = Colors.white70;
      stopwatch.start();
      timer = Timer.periodic(
        Duration(
          milliseconds: 20,
        ),
        updateTime,
      );
    }
  }

  translateTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    String hundredsString = (hundreds % 100).toString().padLeft(2, '0');
    String secondsString = (seconds % 60).toString().padLeft(2, '0');
    String minutesString = (minutes % 60).toString().padLeft(2, '0');
    String hoursString = (hours % 60).toString().padLeft(2, '0');
    return '$hoursString : $minutesString : $secondsString.$hundredsString';
  }

  stopWatch() {
    setState(
      () {
        if (stopwatch.isRunning) {
          lapList.insert(
            0,
            translateTime(
              stopwatch.elapsedMilliseconds,
            ),
          );
        } else {
          stopwatch.reset();
          lapList.clear();
        }
      },
    );
  }

  String listItems(int listLength, int index, String time) {
    index = listLength - index;
    String indexText = index.toString().padLeft(2, '0');
    return 'Time $indexText, $time';
  }
}

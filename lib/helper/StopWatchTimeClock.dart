import 'package:flutter/material.dart';
import 'package:flutter_clock/helper/timerclass.dart';
import 'package:flutter_clock/pages/stopwatch_view.dart';

class StopWatchClock extends StatefulWidget {
  final Stopwatch stopwatch;

  const StopWatchClock({
    Key key,
    this.stopwatch,
  }) : super(key: key);

  StopWatchClockState createState() => StopWatchClockState();
}

class StopWatchClockState extends State<StopWatchClock> {
  CurrentTime currentTime;
  Paint painter;

  @override
  void initState() {
    painter = Paint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentTime = translateCurrentTime(
      widget.stopwatch.elapsedMilliseconds,
    );
    return CustomPaint(
      painter: StopWatchPainter(
        lineColor: Colors.lightBlueAccent,
        completeColor: Colors.blueAccent,
        hundreds: currentTime.hundreds,
        seconds: currentTime.seconds,
        minutes: currentTime.minutes,
        hours: currentTime.hours,
        width: 5.0,
        linePainter: painter,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentTime.hours.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.white70,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentTime.minutes.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  ' : ',
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '${currentTime.seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            Text(
              currentTime.hundreds.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  translateCurrentTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    return CurrentTime(
      hundreds: hundreds % 100,
      seconds: seconds % 60,
      minutes: minutes % 60,
      hours: hours % 24,
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/theme_data.dart';
import 'package:flutter_clock/pages/clock_view.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezone = now.timeZoneOffset.toString().split('.').first;
    var offSetSign = '';
    if (!timezone.startsWith('-')) {
      offSetSign = '+';
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              "Clock",
              style: TextStyle(
                color: CustomColors.primaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                fontFamily: 'avenir',
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DigitalClockWidget(),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: CustomColors.primaryTextColor,
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time Zone",
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primaryTextColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: CustomColors.primaryTextColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "UTC " + offSetSign + " " + timezone,
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: CustomColors.primaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(
    DateTime.now(),
  );
  Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      (timer) {
        var perviousMinute = DateTime.now()
            .add(
              Duration(
                seconds: -1,
              ),
            )
            .minute;
        var currentMinute = DateTime.now().minute;
        if (perviousMinute != currentMinute)
          setState(() {
            formattedTime = DateFormat('HH:mm').format(
              DateTime.now(),
            );
          });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Digital Clock Updated');
    return Text(
      formattedTime,
      style: TextStyle(
        fontFamily: 'avenir',
        color: CustomColors.primaryTextColor,
        fontSize: 64,
      ),
    );
  }
}

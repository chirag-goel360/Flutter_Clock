import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/theme_data.dart';
import 'package:flutter_clock/data/alarm_data.dart';
import 'package:flutter_clock/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>(
                (alarm) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 32,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: alarm.gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: alarm.gradientColors.last.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(
                            4,
                            4,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'office',
                                  style: TextStyle(
                                    color: CustomColors.primaryTextColor,
                                    fontFamily: 'avenir',
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: true,
                              activeColor: CustomColors.primaryTextColor,
                              onChanged: (bool value) {},
                            ),
                          ],
                        ),
                        Text(
                          'Mon-Fri',
                          style: TextStyle(
                            color: CustomColors.primaryTextColor,
                            fontFamily: 'avenir',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '07:00 AM',
                              style: TextStyle(
                                color: CustomColors.primaryTextColor,
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                              color: CustomColors.primaryTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ).followedBy(
                [
                  DottedBorder(
                    strokeWidth: 2,
                    dashPattern: [
                      5,
                      4,
                    ],
                    color: CustomColors.clockOutline,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(24),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        color: CustomColors.clockBackground,
                      ),
                      child: TextButton(
                        onPressed: () {
                          scheduleAlarm();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/add_alarm.png',
                              scale: 1.5,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Add Alarm',
                              style: TextStyle(
                                color: CustomColors.primaryTextColor,
                                fontFamily: 'avenir',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduledNotificationDateTime = DateTime.now().add(
      Duration(
        seconds: 10,
      ),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound(
        'a_long_cold_sting',
      ),
      largeIcon: DrawableResourceAndroidBitmap(
        'logo',
      ),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Office',
      'Good Morning',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }
}

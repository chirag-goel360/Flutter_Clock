import 'package:flutter_clock/constants/theme_data.dart';
import 'package:flutter_clock/models/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(
    DateTime.now().add(
      Duration(
        hours: 1,
      ),
    ),
    description: 'Office',
    gradientColors: GradientColors.sky,
  ),
  AlarmInfo(
    DateTime.now().add(
      Duration(
        hours: 1,
      ),
    ),
    description: 'School',
    gradientColors: GradientColors.sunset,
  ),
];

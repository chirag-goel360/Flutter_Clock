import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/theme_data.dart';
import 'package:flutter_clock/data/menu_data.dart';
import 'package:flutter_clock/helper/enums.dart';
import 'package:flutter_clock/models/menu_info.dart';
import 'package:flutter_clock/pages/alarm_page.dart';
import 'package:flutter_clock/pages/clock_page.dart';
import 'package:flutter_clock/pages/stopwatch_page.dart';
import 'package:flutter_clock/pages/timer_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) {
              return buildFlatButton(currentMenuInfo);
            }).toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.alarm) {
                  return AlarmPage();
                } else if (value.menuType == MenuType.clock) {
                  return ClockPage();
                } else if (value.menuType == MenuType.stopwatch) {
                  return StopWatchPage();
                } else if (value.menuType == MenuType.timer) {
                  return TimerPage();
                }
                return Container(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: 'Left',
                        ),
                        TextSpan(
                          text: value.title,
                          style: TextStyle(
                            fontSize: 48,
                          ),
                        ),
                      ],
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

  Widget buildFlatButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            backgroundColor: currentMenuInfo.menuType == value.menuType
                ? CustomColors.menuBackgroundColor
                : CustomColors.transparent,
          ),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(
              context,
              listen: false,
            );
            menuInfo.onchangeMenuInfo(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                  fontFamily: 'avenir',
                  color: CustomColors.primaryTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

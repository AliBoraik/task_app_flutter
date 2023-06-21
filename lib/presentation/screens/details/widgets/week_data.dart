import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekData extends StatelessWidget {
  DateTime dateTime;
  WeekData({
    super.key,
    required this.dateTime,
  });

  final weeklist =
      DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;
  final dayslist = [1, 2, 3, 4, 5, 6, 7, 8];
  final selectedindex = 4;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
        height: deviceSize.height * 0.13,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                7,
                (index) {
                  return _buildDayAndWeek(index);
                },
              ),
            ),
          ],
        ));
  }

  Container _buildDayAndWeek(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selectedindex == index ? Colors.grey.withOpacity(0.1) : null,
      ),
      child: Column(
        children: [
          Text(
            weeklist[index].substring(0, 3),
            style: TextStyle(
              color: selectedindex == index ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            dayslist[index].toString(),
            style: TextStyle(
              color: selectedindex == index ? Colors.black : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class TimeSetter extends StatefulWidget {
  const TimeSetter({
    super.key,
  });

  @override
  State<TimeSetter> createState() => _TimeSetterState();
}

class _TimeSetterState extends State<TimeSetter> {
  Time _time = Time(hour: 11, minute: 30);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            showPicker(
              iosStylePicker: true,
              accentColor: Color(0xff8D6E63),
              context: context,
              value: _time,
              minHour: 8,
              maxHour: 20,
              onChange: onTimeChanged,
              minuteInterval: TimePickerInterval.FIFTEEN,
              // Optional onChange to receive value as DateTime
              onChangeDateTime: (DateTime dateTime) {
                // print(dateTime);
                debugPrint("[debug datetime]:  $dateTime");
              },
            ),
          );
        },
        child: Icon(Icons.keyboard_arrow_right_rounded));
  }
}

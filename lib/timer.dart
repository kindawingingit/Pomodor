import 'package:flutter/material.dart';
import 'dart:async';

class TimerDisplay extends StatefulWidget {
  const TimerDisplay({Key? key}) : super(key: key);

  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  int _start = 10;
  late Timer _timer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startTimer();
            },
            child: Text('Start'),
          ),
          Text('$_start')
        ],
      ),
    );
  }
}

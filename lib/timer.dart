import 'package:flutter/material.dart';
import 'dart:async';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class TimerDisplay extends StatefulWidget {
  const TimerDisplay({Key? key}) : super(key: key);

  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Timer _timer;
  bool _startIsButtonPressed = false;
  bool _stopIsButtonPressed = false;
  static int minutes = 5;
  static int seconds = 0;
  String secondsString = '00';
  String minutesString = '$minutes';
  int _start = minutes * 60;
  int session = 1;
  bool shortBreak = false;
  final textColor = Color.fromARGB(255, 184, 181, 181);

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _startIsButtonPressed = true;
    _stopIsButtonPressed = false;
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _startIsButtonPressed = false;
          shortBreak = !shortBreak;
        });
        if (shortBreak) {
          setState(() {
            minutes = 2;
            seconds = 0;
          });
        } else {
          session++;
          setState(() {
            minutes = 5;
            seconds = 0;
          });
        }
        if (session > 4) {
          setState(() {
            session = 1;
            minutes = 20;
            seconds = 0;
          });
        }
        setState(() {
          _start = minutes * 60;
          secondsString = '0$seconds';
          minutesString = '$minutes';
        });
      } else {
        setState(() {
          _start--;
          minutes = _start ~/ 60;
          seconds = _start % 60;
        });
        if (seconds > 10)
          secondsString = '$seconds';
        else
          secondsString = '0$seconds';

        if (minutes > 10)
          minutesString = '$minutes';
        else
          minutesString = '0$minutes';
      }
    });
  }

  void stopTimer() {
    setState(() {
      _startIsButtonPressed = false;
      _stopIsButtonPressed = true;
    });
    _timer.cancel();
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
          Padding(
            padding: EdgeInsets.all(40),
            child: Text(
              'Session $session of 4',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),
          Row(
            children: [
              GlassContainer(
                height: 130,
                blur: 3,
                shadowStrength: 10,
                opacity: 0.2,
                width: 200,
                border: Border.fromBorderSide(BorderSide.none),
                borderRadius: BorderRadius.circular(10),
                child: Center(
                    child: Text(
                  '$minutesString',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 70),
                )),
              ),
              SizedBox(
                width: 20,
              ),
              GlassContainer(
                height: 130,
                blur: 3,
                shadowStrength: 10,
                opacity: 0.2,
                width: 200,
                border: Border.fromBorderSide(BorderSide.none),
                borderRadius: BorderRadius.circular(10),
                child: Center(
                    child: Text(
                  '$secondsString',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 70),
                )),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _startIsButtonPressed ? null : startTimer,
                child: Text('Start'),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.grey[300],
                    onSurface: Color.fromARGB(255, 255, 255, 255),
                    disabledMouseCursor: SystemMouseCursors.basic,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: _stopIsButtonPressed ? null : stopTimer,
                child: Text('Stop'),
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.grey[300],
                    onSurface: Color.fromARGB(255, 255, 255, 255),
                    disabledMouseCursor: SystemMouseCursors.basic,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  TimerScreen({@required this.timeToCount});

  final double timeToCount;

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer _timer;
  double _counter = 0;
  bool _timerStarted = false;

  void startTimer() {
    if (!_timerStarted) {
      _timerStarted = true;
      const oneSec = const Duration(milliseconds: 60);
      _timer = new Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_counter > widget.timeToCount) {
                  timer.cancel();
                  _timerStarted = false;
                } else {
                  _counter = _counter + 0.001;
                }
              }));
    }
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  @override
  void deactivate() {
    super.deactivate();
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Stack(children: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_counter > 0)
                  Text(
                    (widget.timeToCount - _counter.floor()).floor().toString() +
                        ' minute remaining',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  minHeight: 15,
                  value: _counter,
                )
              ],
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  strokeWidth: 10,
                  value: _counter,
                )
              ],
            ),
          ))
        ]));
  }
}

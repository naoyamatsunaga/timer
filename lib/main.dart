import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Timer'),
    );
  }
}

// StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minutes = 0;
  int _seconds = 0;
  int _milliSeconds = 0;

  // nullを許容する
  Timer? _secondTimer;
  Timer? _milliSecondTimer;

  bool _isRunning = false;

  @override
  // 画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();
  }

  void secondTimerStart() {
    _secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }
      });

      // 5秒後に画面遷移する
      // if (_seconds == 5) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => NextPage()),
      //   );
      //   toggleTimer();
      //   timerReset();
      // }
    });
  }

  void millisecondTimerStart() {
    _milliSecondTimer =
        Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliSeconds++;
        if (_milliSeconds == 100) {
          _milliSeconds = 0;
        }
      });
    });
  }

  void timerStop() {
    setState(() {
      _secondTimer?.cancel();
      _milliSecondTimer?.cancel();
    });
  }

  void toggleTimer() {
    setState(() {
      if (_isRunning) {
        timerStop();
      } else {
        secondTimerStart();
        millisecondTimerStart();
      }
      _isRunning = !_isRunning;
    });
  }

  void timerReset() {
    setState(() {
      _minutes = 0;
      _seconds = 0;
      _milliSeconds = 0;
    });
  }

  // 画面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}.${_milliSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 75,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
              },
              child: Text(
                _isRunning ? 'ストップ' : 'スタート',
                style: TextStyle(
                    fontSize: 20,
                    color: _isRunning ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_isRunning) {
                  toggleTimer();
                }
                timerReset();
              },
              child: const Text(
                'リセット',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

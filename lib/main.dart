import 'dart:async';

import 'package:flutter/material.dart';

import 'next_page.dart';

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
  int _seconds = 0;

  // nullを許容する
  Timer? _timer;

  bool _isRunning = false;

  @override
  // 画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();
  }

  void timerStart() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
      if (_seconds == 5) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage()),
        );
      }
    });
  }

  void timerStop() {
    setState(() {
      _timer?.cancel();
    });
  }

  void toggleTimer() {
    setState(() {
      if (_isRunning) {
        timerStop();
      } else {
        timerStart();
      }
      _isRunning = !_isRunning;
    });
  }

  void timerReset() {
    setState(() {
      _seconds = 0;
    });
  }

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
              '$_seconds',
              style: const TextStyle(fontSize: 100),
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

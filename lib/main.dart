import 'dart:async';

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
  int _seconds = 0;
  // nullを許容する
  Timer? _timer;

  @override
  // 画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();

    // 1秒ごとにカウントアップ
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _timerStop() {
    setState(() {
      _timer?.cancel();
    });
  }

  void _timerReset() {
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
                _timerStop();
              },
              child: const Text('ストップ'),
            ),
            ElevatedButton(
              onPressed: () {
                _timerReset();
              },
              child: const Text('リセット'),
            ),
          ],
        ),
      ),
    );
  }
}

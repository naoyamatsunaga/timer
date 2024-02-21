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

  @override
  // 画面を開いた時に最初に呼ばれる関数
  void initState() {
    super.initState();

    // 1秒ごとにカウントアップ
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _incrementSeconds() {
    setState(() {
      _seconds++;
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
        child: Text(
          '$_seconds',
          style: const TextStyle(fontSize: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementSeconds,
        child: const Icon(Icons.add),
      ),
    );
  }
}

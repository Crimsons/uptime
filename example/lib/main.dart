import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uptime/uptime.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _uptime = 0;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    int uptime;
    try {
      uptime = await Uptime.uptime;
    } on PlatformException {
      uptime = 0;
    }

    if (!mounted) return;

    setState(() {
      _uptime = uptime;
    });
  }

  @override
  Widget build(BuildContext context) {
    var duration = Duration(milliseconds: _uptime);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Uptime plugin example app'),
        ),
        body: Center(
          child: Text('Uptime: ${duration.toString()}'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: refresh, child: Icon(Icons.refresh)),
      ),
    );
  }
}

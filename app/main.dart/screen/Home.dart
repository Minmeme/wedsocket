import 'package:flutter/material.dart';
import 'screen/Home.dart'; // Import the HomePage class from the new file.
// import 'screen/connect.dart';
// import 'screen/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
      ),
      home: HomePage(
        // WebSocket will be set up in the HomePage class, no need to pass parameters here.
      ),
    );
  }
}

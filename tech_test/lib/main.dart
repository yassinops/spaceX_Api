// lib/main.dart
import 'package:flutter/material.dart';
import 'package:tech_test/ui/home_page.dart';


void main() {
  runApp(MyApp()); // Run the app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Launches', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Default theme color
      ),
      home: HomePage(), // Set the LaunchListScreen as the home screen
    );
  }
}
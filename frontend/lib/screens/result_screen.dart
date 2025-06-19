import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Center(
          child: Column(
            children: [Text('Estimated Value', style: TextStyle(fontSize: 24))],
          ),
        ),
      ),
    );
  }
}

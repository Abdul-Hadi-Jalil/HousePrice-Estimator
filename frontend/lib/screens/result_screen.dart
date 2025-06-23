import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final dynamic
  predictionResult; // Consider using a specific type (e.g., `double` or `String`)

  const ResultScreen({super.key, required this.predictionResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'), // Add a title for better UX
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ), // Fixed: Use `EdgeInsets.all()` instead of `EdgeInsetsGeometry`
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              Text(
                'Estimated Value: Rs $predictionResult',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Add spacing
              ElevatedButton(
                onPressed: () => Navigator.pop(context), // Allow going back
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

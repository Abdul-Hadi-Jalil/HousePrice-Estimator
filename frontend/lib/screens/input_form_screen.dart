import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/result_screen.dart';
import 'package:http/http.dart' as http;

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  String? selectedLocation;
  String? selectedCity;
  String? selectedPropertyType;
  final TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  TextEditingController areaInMarlaController = TextEditingController();

  Future<dynamic> startPrediction() async {
    final predictionData = {
      'location': selectedLocation,
      'property_type': selectedPropertyType,
      'city': selectedCity,
      'baths': bathroomController.text,
      'bedrooms': bedroomController.text,
      'Area_in_Marla': areaInMarlaController.text,
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(predictionData),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
  }

  @override
  void dispose() {
    areaInMarlaController.dispose();
    bathroomController.dispose();
    bedroomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              Text(
                'Estimate your Home\'s value',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              DropdownMenu<String>(
                initialSelection: selectedLocation,
                onSelected: (String? value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
                width: 400,
                label: Text('Location'),
                leadingIcon: Icon(Icons.location_city),
                menuHeight: 200,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(value: 'G-10', label: 'G-10'),
                  DropdownMenuEntry<String>(value: 'E-11', label: 'E-11'),
                  DropdownMenuEntry<String>(value: 'G-15', label: 'G-15'),
                  DropdownMenuEntry<String>(
                    value: 'Defence Fort',
                    label: 'Defence Fort',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Sihala Valley',
                    label: 'Sihala Valley',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Shahra-e-Liaquat',
                    label: 'Shahra-e-Liaquat',
                  ),
                ],
              ),
              DropdownMenu<String>(
                initialSelection: selectedPropertyType,
                onSelected: (String? value) {
                  setState(() {
                    selectedPropertyType = value;
                  });
                },
                width: 400,
                label: Text('Property Type'),
                menuHeight: 200,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(value: 'Flat', label: 'Flat'),
                  DropdownMenuEntry<String>(value: 'House', label: 'House'),
                ],
              ),
              DropdownMenu<String>(
                initialSelection: selectedCity,
                onSelected: (String? value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                width: 400,
                label: Text('City'),
                menuHeight: 200,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(value: 'Karachi', label: 'Karachi'),
                  DropdownMenuEntry<String>(value: 'Lahore', label: 'Lahore'),
                  DropdownMenuEntry<String>(
                    value: 'Faisalabad',
                    label: 'Faisalabad',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Rawalpindi',
                    label: 'Rawalpindi',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Islamabad',
                    label: 'Islamabad',
                  ),
                ],
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: areaInMarlaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Area in Marla'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: bedroomController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Bedrooms'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: bathroomController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Bathrooms'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final predictionResult = startPrediction();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultScreen(predictionResult: predictionResult),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text('Start Prediction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

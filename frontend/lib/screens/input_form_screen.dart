import 'package:flutter/material.dart';
import 'package:frontend/screens/result_screen.dart';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
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
                width: 400,
                label: Text('Property Type'),

                menuHeight: 200,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(value: 'Flat', label: 'Flat'),
                  DropdownMenuEntry<String>(value: 'House', label: 'House'),
                ],
              ),
              DropdownMenu<String>(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen()),
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

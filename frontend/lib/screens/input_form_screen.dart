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
                  DropdownMenuEntry<String>(
                    value: 'DHA, Lahore',
                    label: 'DHA, Lahore',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Valencia, Lahore',
                    label: 'Valencia, Lahore',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Eden City, Lahore',
                    label: 'Eden City, Lahore',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Pine Avenue, Lahore',
                    label: 'Pine Avenue, Lahore',
                  ),
                  DropdownMenuEntry<String>(
                    value: 'Wapda Town, Lahore',
                    label: 'Wapda Town, Lahore',
                  ),
                ],
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Area (sq. ft.)'),
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
              SizedBox(
                width: 400,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Year Built (Optional)'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              DropdownMenu<String>(
                width: 400,
                label: Text('Condition (Optional)'),
                menuHeight: 200,
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(value: 'Poor', label: 'Poor'),
                  DropdownMenuEntry<String>(value: 'Good', label: 'Good'),
                  DropdownMenuEntry<String>(value: 'Fair', label: 'Fair'),
                ],
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

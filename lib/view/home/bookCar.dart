import 'package:flutter/material.dart';
import 'package:tubes_ui/view/home/home.dart';

class BookCarPage extends StatefulWidget {
  const BookCarPage({Key? key}) : super(key: key);

  @override
  _BookCarPageState createState() => _BookCarPageState();
}

class _BookCarPageState extends State<BookCarPage> {
  String _selectedCar = 'Porsche';
  String _startDateTime = '';
  final String _endDateTime = '';
  String _pickupLocation = '';

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != _startDate)
      setState(() {
        _startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != _endDate)
      setState(() {
        _endDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()),
                      );
                    },
                  ),
                  const Text(
                    'Date & Time',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Car',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _selectedCar,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCar = newValue;
                        });
                      }
                    },
                    items: <String>[
                      'Porsche',
                      'Ferrari',
                      'Aston',
                      'Mercy',
                      'Supra',
                      'McLaren'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pick-up Location',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter pick-up Location',
                      suffixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Date',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    readOnly: false,
                    controller: TextEditingController(),
                    onTap: () {
                      _selectStartDate(context);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Start Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'End Date',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    readOnly: false,
                    controller: TextEditingController(),
                    onTap: () {
                      _selectEndDate(context);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select End Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 100.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(450, 40),
                    backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      _startDateTime = _startDateTime.toString();
                      _pickupLocation = '';
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

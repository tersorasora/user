import 'package:flutter/material.dart';
// import 'package:tubes_ui/view/home/location.dart';
import 'package:tubes_ui/view/home/pay.dart';

class BookCarPage extends StatefulWidget {
  const BookCarPage ({super.key});

  @override
  _BookCarPageState createState() => _BookCarPageState();
}

class _BookCarPageState extends State<BookCarPage> {
  String _startDateTime = '';
  String _endDateTime = '';
  String _pickupLocation = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _pickupTime = TimeOfDay.now();
  TimeOfDay _returnTime = TimeOfDay.now();
  bool _bookWithDriver = false;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024));
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
        lastDate: DateTime(2024));
    if (picked != null && picked != _endDate)
      setState(() {
        _endDate = picked;
      });
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _pickupTime);
    if (picked != null && picked != _pickupTime)
      setState(() {
        _pickupTime = picked;
      });
  }

  Future<void> _selectReturnTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _returnTime);
    if (picked != null && picked != _returnTime)
      setState(() {
        _returnTime = picked;
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
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Date & Time',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 40.0),
            ],
          ),
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Book with driver?',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Switch(
                        value: _bookWithDriver,
                        onChanged: (value) {
                          setState(() {
                            _bookWithDriver = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text("Don't have a driver? Book with the driver"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pick-up Location',
                    hintText: 'Enter pick-up Location',
                    suffixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: false,
                  controller: TextEditingController(),
                  onTap: () {
                    _selectStartDate(context);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Start Date',
                    hintText: 'Select Start Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: false,
                  controller: TextEditingController(),
                  onTap: () {
                    _selectEndDate(context);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'End Date',
                    hintText: 'Select End Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: false,
                  controller: TextEditingController(),
                  onTap: () {
                    _selectPickupTime(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Pick-up Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  readOnly: false,
                  controller: TextEditingController(),
                  onTap: () {
                    _selectReturnTime(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Return Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(450, 40),
                backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
              ),
              onPressed: () {
                setState(() {
                  _startDateTime = _startDateTime.toString();
                  _endDateTime = _endDateTime.toString();
                  _pickupLocation = '';
                });
                Navigator.pushReplacement(
                  
                  context,
                  MaterialPageRoute(builder: (context) => PayPage(
                    startDateTime: _startDateTime,
                    endDateTime: _endDateTime,
                    pickupLocation: _pickupLocation)),
                );
              },
              child: Text('Booking'),
            ),
          ),
        ],
      ),
    )));
  }
}

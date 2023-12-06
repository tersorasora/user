import 'package:flutter/material.dart';

class OpenCarPage extends StatefulWidget {
  const OpenCarPage({super.key});

  @override
  _OpenCarPageState createState() => _OpenCarPageState();
}

class _OpenCarPageState extends State<OpenCarPage> {
  final List<Map<String, dynamic>> _specifications = [
    {
      'icon': Icons.battery_full,
      'title': 'Max Power',
      'value': '320 hp',
    },
    {
      'icon': Icons.local_gas_station,
      'title': 'Fuel',
      'value': '550 km',
    },
    {
      'icon': Icons.speed,
      'title': '0-60 mph',
      'value': '2.6 sec',
    },
    {
      'icon': Icons.speed,
      'title': 'Max Speed',
      'value': '177 mph',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'GR YARIS',
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20.0,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.8',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Toyota',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/car1.jpeg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    'Specifications',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _specifications.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 120,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(_specifications[index]['icon']),
                                        const SizedBox(height: 5),
                                        Text(_specifications[index]['title']),
                                        Text(
                                          _specifications[index]['value'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Car Features',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildFeatureRow(Icons.people, '2 Passengers', '4 Doors'),
                  buildFeatureRow(Icons.ac_unit, 'Snow Tires', 'GPS'),
                  buildFeatureRow(Icons.bluetooth, 'Bluetooth', 'Manual'),
                  const SizedBox(height: 20),
                  const Text(
                    'Review',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mobilnya enak sekali'),
                          Text(
                            'User',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              const Text(
                'Rp 500.000/Day',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      double maxHeight =
                          MediaQuery.of(context).size.height * 0.65;

                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: maxHeight,
                        ),
                        child:
                            buildCombinedBottomSheet(), // Panggil widget baru
                      );
                    },
                  );
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpecCard(IconData icon, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureRow(IconData leftIcon, String text, String rightText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leftIcon,
                color: const Color.fromRGBO(127, 90, 240, 1),
              ),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.door_back_door,
                color: Color.fromRGBO(127, 90, 240, 1),
              ),
              const SizedBox(width: 5),
              Text(rightText),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCombinedBottomSheet() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(127, 90, 240, 1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          padding: const EdgeInsets.all(25.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GR YARIS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '2 Passengers',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            // color: Colors.grey,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: buildSpecCard(
                      Icons.calendar_today,
                      'Start',
                      'Select start date',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildSpecCard(
                      Icons.calendar_today,
                      'End',
                      'Select end date',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Pick-up Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              buildSpecCard(
                Icons.location_on,
                '',
                'Select location',
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              buildSpecCard(
                Icons.credit_card,
                'MasterCard',
                '**** **** 1234 5678',
              ),
              const SizedBox(height: 10),
              buildSpecCard(
                Icons.scanner,
                '',
                'SCAN QR',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      // Add functionality for Print PDF
                    },
                    child: const Text('Print PDF'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(127, 90, 240, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      // Add functionality for Booking
                    },
                    child: const Text('Booking'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

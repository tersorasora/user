import 'package:flutter/material.dart';
import 'package:tubes_ui/view/home/bookCar.dart';

class OpenCarPage extends StatefulWidget {
  const OpenCarPage({super.key});
  
  @override
  _OpenCarPageState createState() => _OpenCarPageState();
}

class _OpenCarPageState extends State<OpenCarPage> {
  List<Map<String, dynamic>> _specifications = [
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toyota',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _specifications.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                                        SizedBox(height: 5),
                                        Text(_specifications[index]['title']),
                                        Text(
                                          _specifications[index]['value'],
                                          style: TextStyle(
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
                  SizedBox(height: 20),
                  Text(
                    'Car Features',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildFeatureRow(Icons.people, '2 Passengers', '4 Doors'),
                  buildFeatureRow(Icons.ac_unit, 'Snow Tires', 'GPS'),
                  buildFeatureRow(Icons.bluetooth, 'Bluetooth', 'Manual'),
                  SizedBox(height: 20),
                  Text(
                    'Review',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
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
                  SizedBox(height: 40),
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
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BookCarPage()),
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
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                leftIcon,
                color: Color.fromRGBO(127, 90, 240, 1),
              ),
              SizedBox(width: 10),
              Text(text),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.door_back_door,
                color: Color.fromRGBO(127, 90, 240, 1),
              ),
              SizedBox(width: 5),
              Text(rightText),
            ],
          ),
        ],
      ),
    );
  }
}

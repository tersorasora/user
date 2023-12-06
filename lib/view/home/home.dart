import 'package:flutter/material.dart';
import 'package:tubes_ui/view/history/history.dart';
import 'package:tubes_ui/view/home/bookCar.dart';
import 'package:tubes_ui/view/home/openCar.dart';
import 'package:tubes_ui/view/home/popularCity.dart';
import 'package:tubes_ui/view/profile/profile.dart';
import 'package:tubes_ui/view/profile/promo.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late String _selectedCar;

  @override
  void initState() {
    super.initState();
  }

  void setSelectedCar(String car) {
    setState(() {
      _selectedCar = car;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _selectedIndex == 2
              ? ProfilePage()
              : _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Location',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Yogyakarta',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/gojohh.jpg'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 14.0),
                          border: InputBorder.none,
                          suffixIcon: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {
                              // Search logic using searchQuery
                            },
                            child:
                                const Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Discover the latest deals and updates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PromoPage()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/promo.jpeg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        child: Center(
                          child: Text(
                            'PROMO',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              backgroundColor:
                                  const Color.fromARGB(255, 74, 73, 73)
                                      .withOpacity(0.5),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Your Cart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(127, 90, 240, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BookCarPage()),
                                );
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OpenCarPage()),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: const Color.fromARGB(255, 208, 205, 205),
                        child: Container(
                            width: 200,
                            height: 320,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(4)),
                                      child: Image.asset(
                                        'assets/images/car1.jpeg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '_selectedCar',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .settings_input_component,
                                                  size: 18),
                                              SizedBox(width: 4),
                                              Text('A/T'),
                                              SizedBox(width: 12),
                                              Icon(Icons.people, size: 18),
                                              SizedBox(width: 4),
                                              Text('5'),
                                              SizedBox(width: 12),
                                              Icon(Icons.car_rental, size: 18),
                                              SizedBox(width: 4),
                                              Text('2'),
                                              SizedBox(width: 12),
                                              Icon(Icons.wb_sunny, size: 18),
                                              SizedBox(width: 4),
                                              Text('A/C'),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        127, 90, 240, 1),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text('Instant Confirmation'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Yogyakarta'),
                                                  SizedBox(width: 4),
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        127, 90, 240, 1),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        127, 90, 240, 1),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text('Free Cancellation'),
                                                ],
                                              ),
                                              SizedBox(width: 70),
                                              Row(
                                                children: [
                                                  Text('Day/'),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Rp 500.000',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          127, 90, 240, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Handle love icon tap
                                    },
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Popular City',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PopularCityPage()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/promo.jpeg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        child: const Center(
                          child: Text(
                            'YOGYAKARTA',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

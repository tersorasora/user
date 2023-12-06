import 'package:flutter/material.dart';
import 'package:tubes_ui/view/profile/profile.dart';
import 'package:tubes_ui/view/profile/subscribe/paket.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  String subscriptionType = 'FREE'; // Default subscription type

  void updateSubscription(String type) {
    setState(() {
      subscriptionType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'SUBSCRIBE',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40.0),
                  ],
                ),
                const SizedBox(height: 20.0),
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/checkmark.png'),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'YOUR ACCOUNT IS $subscriptionType',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                // const Text(
                //   'Subscribe to get a free and amazing offers and other cool things',
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 20.0),

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
                          builder: (context) => const PaketPage()),
                    );
                  },
                  child: const Text('MULAI'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

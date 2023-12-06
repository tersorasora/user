import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_ui/view/login/login.dart';
import 'package:tubes_ui/view/profile/bookmark.dart';
import 'package:tubes_ui/view/profile/contactUs.dart';
import 'package:tubes_ui/view/profile/friendList.dart';
import 'package:tubes_ui/view/profile/history/history.dart';
import 'package:tubes_ui/view/profile/payment/payment.dart';
import 'package:tubes_ui/view/profile/editProfile.dart';
import 'package:tubes_ui/view/profile/notification.dart';
import 'package:tubes_ui/view/profile/promo.dart';
import 'package:tubes_ui/view/profile/settings/settings.dart';
import 'package:tubes_ui/client/userClient.dart';
// import 'package:tubes_ui/view/profile/subscribe/paket.dart';
import 'package:tubes_ui/view/profile/subscribe/subscribe.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  Uint8List? userImage;

  Future<void> takeUser() async {
    int userId;
    userId = await getPrefsId();
    UserClient.find(userId).then((userDataFromDatabase) {
      print("Response from server: $userDataFromDatabase");
      setState(() {
        userData = userDataFromDatabase.toJson();
        print(userData);
        String base64Image = userData!['image'] ?? "default";
        if (base64Image != "default") {
          userImage = Uint8List.fromList(base64Decode(base64Image));
        }
      });
    });
  }

  @override
  void initState() {
    print("User: $userData");
    takeUser();
    super.initState();
  }

  getPrefsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = await prefs.getInt('userId') ?? 0;
    return id;
  }

  void clearPrefsId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                              builder: (context) => NotificationPage()),
                        );
                      },
                      child: const Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/gojohh.jpg'),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  userData?['username'] ?? "Gojo Satoru",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(userData: userData ?? {})),
                  );
                },
                child: const Center(
                  child: Text(
                    'View and Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildCard(
                    icon: Icons.bookmark,
                    title: 'BOOKMARKS',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BookmarkPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.subscriptions,
                    title: 'SUBSCRIBE',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubscribePage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.settings,
                    title: 'SETTINGS',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.history,
                    title: 'HISTORY',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.payment,
                    title: 'PAYMENT',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.bookmark,
                    title: 'PROMOS',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PromoPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.group,
                    title: 'FRIENDS LIST',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendListPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.chat,
                    title: 'CONTACT US',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsPage()),
                      );
                    },
                  ),
                  buildCard(
                    icon: Icons.exit_to_app,
                    title: 'SIGN OUT',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(height: 4.0),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

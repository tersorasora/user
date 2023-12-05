import 'package:flutter/material.dart';
import 'package:tubes_ui/client/userClient.dart';
import 'package:tubes_ui/entity/user.dart';
import 'package:tubes_ui/view/profile/notification.dart';
import 'package:tubes_ui/view/profile/profile.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController emailController;
  late TextEditingController dobController;
  late TextEditingController noTelpController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.userData['email']);
    dobController = TextEditingController(text: widget.userData['tglLahir']);
    noTelpController = TextEditingController(text: widget.userData['noTelp']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: const Icon(Icons.arrow_back),
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
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/gojohh.jpg'),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.userData['username'] ?? 'Gojo Satoru',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Joined at today',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: const Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              buildEditableCard('Email', emailController),
              buildEditableCard('Date of Birth', dobController),
              buildEditableCard('Phone Number', noTelpController),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  updateProfile();
                },
                child: const Text('Update profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // String formatDateTime(Timestamp? timestamp) {
  //   if (timestamp == null) {
  //     return ''; // Handle null case as needed
  //   }
  //   return DateFormat.yMMMM('en_US').format(timestamp.toDate());
  // }

  Widget buildEditableCard(String title, TextEditingController controller) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    User updatedUser = User(
      id: widget.userData['id'],
      username: widget.userData['username'],
      email: emailController.text,
      password: widget.userData['password'],
      tglLahir: dobController.text,
      noTelp: noTelpController.text,
      // updated_at: Timestamp.now(),
    );

    try {
      await UserClient.update(updatedUser);
      print('Message Updated');
    } catch (e) {
      print('Error Updating Message : $e');
    }
  }
}

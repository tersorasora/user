import 'package:flutter/material.dart';
import 'package:tubes_ui/entity/user.dart';
import 'package:tubes_ui/view/login/login.dart';
import 'package:tubes_ui/client/userClient.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (picked.isAfter(currentDate)) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Tanggal lahir tidak boleh lebih dari tanggal hari ini.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          selectedDate = picked;
          dobController.text =
              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
        });
      }
    }
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextFormField(
            //         controller: firstNameController,
            //         decoration: const InputDecoration(
            //             labelText: 'First Name', border: OutlineInputBorder()),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Expanded(
            //       child: TextFormField(
            //         controller: lastNameController,
            //         decoration: const InputDecoration(
            //             labelText: 'Last Name', border: OutlineInputBorder()),
            //       ),
            //     ),
            //   ],
            // ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: 'Username', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              // Validation logic can be added here
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                  labelText: 'Phone Number', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(127, 90, 240, 1),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: const Text(
                        'Apakah sudah yakin dengan data yang diisi?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Belum'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform the registration
                          final newUser = User(
                            username: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            noTelp: phoneNumberController.text,
                            tglLahir: dobController.text,
                            image: 'default',
                          );

                          UserClient.register(newUser);

                          Navigator.of(context)
                              .pop(); // Close the confirmation dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage(
                                    data: {'registrationSuccess': true})),
                          );
                        },
                        child: const Text('Sudah'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    ));
  }
}

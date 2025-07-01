import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signin_screen.dart';
import 'datauser.dart';

// Tambahkan controller di atas
final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String userType = 'Anonymous';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Logo dan Nama Aplikasi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 55),
                  const SizedBox(width: 8),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Be',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'wara',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Input Fields
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Radio Buttons
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "I am a",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Reporter',
                    groupValue: userType,
                    onChanged: (value) {
                      setState(() {
                        userType = value!;
                      });
                    },
                  ),
                  const Text('Reporter'),
                  Radio(
                    value: 'Visitor',
                    groupValue: userType,
                    onChanged: (value) {
                      setState(() {
                        userType = value!;
                      });
                    },
                  ),
                  const Text('Visitor'),
                ],
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    // Simpan data user ke SharedPreferences
                    await UserPrefs.saveUser(
                      username: usernameController.text,
                      email: emailController.text,
                      role: userType,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(
                          registeredUsername: usernameController.text,
                          registeredEmail: emailController.text,
                          registeredPassword: passwordController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ),

              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('or sign in with'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(FontAwesomeIcons.envelope, Colors.red),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.google, Colors.blue),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.facebookF, Colors.blueAccent),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.twitter, Colors.lightBlue),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.apple, Colors.black),
                ],
              ),

              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: "By signing up to Bewara you are accepting our ",
                  children: [
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData iconData, Color color) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey[200],
      child: FaIcon(iconData, color: color, size: 20),
    );
  }
}

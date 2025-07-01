import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'beranda.dart';

class SignInScreen extends StatefulWidget {
  final String registeredUsername;
  final String registeredEmail;
  final String registeredPassword;

  const SignInScreen({
    super.key,
    required this.registeredUsername,
    required this.registeredEmail,
    required this.registeredPassword,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String error = '';

  void _signIn() {
    if (usernameController.text == widget.registeredUsername &&
        passwordController.text == widget.registeredPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BerandaScreen()),
      );
    } else {
      setState(() {
        error = 'Login gagal. Cek username dan password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Logo dan nama aplikasi
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
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _signIn,
                  child: const Text('Sign In'),
                ),
              ),
              if (error.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(error, style: const TextStyle(color: Colors.red)),
              ],

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
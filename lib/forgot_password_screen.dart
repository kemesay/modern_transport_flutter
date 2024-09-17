import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modern_transportation/widgets/gradient_button.dart';
import 'package:modern_transportation/widgets/login_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  Future<void> _sendPasswordResetEmail(String email) async {
    final url =
        Uri.parse('http://192.168.140.173:5100/api/v1/auth/forgot-password');
    final response = await http.post(
      url,
      body: '{"email": "$email"}',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password reset email sent successfully!')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send reset email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                Image.asset('assets/images/image15.png'),
                const SizedBox(height: 50),
                LoginField(
                  hintText: 'Email',
                  controller: emailController,
                  obscureText: false,
                  suffixIcon: const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your email')),
                      );
                    } else {
                      _sendPasswordResetEmail(email);
                    }
                  },
                  label: 'Submit Email',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

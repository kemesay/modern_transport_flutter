import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modern_transportation/login_screen.dart';
import 'package:modern_transportation/widgets/gradient_button.dart';
import 'package:modern_transportation/widgets/login_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String resetToken;
  
  const ResetPasswordScreen({super.key, required this.resetToken});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();

}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();

  Future<void> _resetPassword(String newPassword) async {
    final url = Uri.parse('http://192.168.1.110:5100/api/v1/auth/reset-password');
    final response = await http.post(
      url,
      body: '{"token": "${widget.resetToken}", "newPassword": "$newPassword"}',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful!')),
      );
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to reset password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              children: [
                LoginField(
                  hintText: 'Enter new password',
                  controller: passwordController,
                  obscureText: true,
                  suffixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    final newPassword = passwordController.text.trim();
                    if (newPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a new password')),
                      );
                    } else {
                      _resetPassword(newPassword);
                    }
                  },
                  label: 'Reset Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

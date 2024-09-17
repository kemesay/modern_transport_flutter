import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_transportation/bloc/auth_bloc.dart'; // Assuming SignUp uses AuthBloc
import 'package:modern_transportation/login_screen.dart';
import 'package:modern_transportation/pallete.dart';
import 'package:modern_transportation/widgets/login_field.dart'; // Reusable input fields
import 'package:modern_transportation/widgets/gradient_button.dart'; // Custom button

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for the form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false; // To manage loading state
//  final  bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;
  bool _passwordVisible = true; // Declare the visibility state for the password

  @override
  void dispose() {
    // Dispose controllers to free resources
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _obscurePassword = !_obscurePassword;
  //   });
  // }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      // All validations passed
      setState(() {
        _isLoading = true;
      });

      final String fullName = _fullNameController.text.trim();
      final String email = _emailController.text.trim();
      final String phoneNumber = _phoneNumberController.text.trim();
      final String password = _passwordController.text.trim();

      // Assuming AuthBloc has a SignUp event
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              fullName: fullName,
              email: email,
              phoneNumber: phoneNumber,
              password: password,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });

            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }

            if (state is AuthSuccess) {
              // Navigate back to login or home screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            }
          }
        },
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name Field
                      LoginField(
                        hintText: 'Full Name',
                        controller: _fullNameController,
                        obscureText: false, // Email is not hidden
                        suffixIcon: const SizedBox
                            .shrink(), // Empty widget since no icon is needed
                      ),
                      const SizedBox(height: 15),

                      // Email Field
                      LoginField(
                        hintText: 'Email',
                        controller: _emailController,
                        obscureText: false, // Email is not hidden
                        suffixIcon: const SizedBox
                            .shrink(), // Empty widget since no icon is needed
                      ),
                      const SizedBox(height: 15),

                      // Phone Number Field
                      LoginField(
                        hintText: 'Phone Number',
                        controller: _phoneNumberController,
                        obscureText: false, // Email is not hidden
                        suffixIcon: const SizedBox
                            .shrink(), // Empty widget since no icon is needed
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      LoginField(
                        hintText: 'Password',
                        controller: _passwordController,
                        obscureText: _passwordVisible, // Pass the visibility state
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible =
                                  !_passwordVisible; // Toggle visibility state
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Confirm Password Field
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(27),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Pallete.borderColor,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Pallete.gradient2,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Confirm Password',
                             suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible =
                                  !_passwordVisible; // Toggle visibility state
                            });
                          },
                        ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Sign Up Button
                      GradientButton(
                        onPressed: _signUp,
                        label: 'Sign Up',
                      ),

                      const SizedBox(height: 15),

                      // Link to Login Screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Login', style: TextStyle( color: Color.fromARGB(255, 153, 213, 153),
                        fontSize: 17,
                      ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_transportation/bloc/auth_bloc.dart';
import 'package:modern_transportation/forgot_password_screen.dart';
import 'package:modern_transportation/home_screen.dart';
import 'package:modern_transportation/sign_up_screen.dart';
import 'package:modern_transportation/widgets/gradient_button.dart';
import 'package:modern_transportation/widgets/login_field.dart';
import 'package:modern_transportation/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MapPage(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/image15.png'),
                  const SizedBox(height: 50),
                  const SocialButton(
                      iconPath: 'assets/svgs/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svgs/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Email',
                    controller: emailController,
                    obscureText: false,
                    suffixIcon: const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: _passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  GradientButton(
                    label: 'Log in',
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter email and password'),
                          ),
                        );
                        return;
                      }

                      context.read<AuthBloc>().add(
                            AuthLoginRequested(
                              email: email,
                              password: password,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 15),
                                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text("Forgot your password?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 213, 153),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 213, 153),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

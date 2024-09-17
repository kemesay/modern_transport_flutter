import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_transportation/bloc/auth_bloc.dart';
import 'package:modern_transportation/home_screen.dart';
import 'package:modern_transportation/repositories/auth_repository.dart';
import 'package:modern_transportation/login_screen.dart';
import 'package:modern_transportation/reset_password_screen.dart';
import 'package:modern_transportation/sign_up_screen.dart';

void main() {
  final authRepository = AuthRepository(baseUrl: 'http://192.168.140.173:5100');
  
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: MaterialApp(
          title: 'Modern Transportation',
          debugShowCheckedModeBanner: false, // Disable the debug banner
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 8, 8, 8),
          ),
          
          // Use `onGenerateRoute` to handle dynamic routes (like reset password)
          onGenerateRoute: (settings) {
            // Parse the current route
            final Uri uri = Uri.parse(settings.name ?? '');
            
            // Check if the route is the reset password route
            if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'reset-password') {
              final resetToken = uri.pathSegments[1]; // Extract resetToken from the URL
              return MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(resetToken: resetToken),
              );
            }

            // Add fallback for routes
            return null; // Return null if the route is not matched (will use routes below)
          },
          
          // Static routes for signup and home
          routes: {
            '/signup': (context) => const SignUpScreen(),
            '/home': (context) => const HomeScreen(),
          },
          
          // Define the initial route (login screen)
          home: const LoginScreen(),
        ),
      ),
    );
  }
}

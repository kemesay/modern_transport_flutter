import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_transportation/bloc/auth_bloc.dart';
import 'package:modern_transportation/pages/add_credit_card_page.dart';
import 'package:modern_transportation/pages/book_page.dart';
import 'package:modern_transportation/pages/credit_card_page.dart';
import 'package:modern_transportation/pages/forgot_password_page.dart';
import 'package:modern_transportation/pages/home_page.dart';
import 'package:modern_transportation/pages/otp_page.dart';
import 'package:modern_transportation/pages/phone_reg_page.dart';
import 'package:modern_transportation/pages/promo_code_page.dart';
import 'package:modern_transportation/pages/rate_driver_page.dart';
import 'package:modern_transportation/pages/book_details_page.dart';
import 'package:modern_transportation/pages/book_history_page.dart';
import 'package:modern_transportation/pages/settings_page.dart';
import 'package:modern_transportation/pages/support_page.dart';
import 'package:modern_transportation/repositories/auth_repository.dart';
import 'package:modern_transportation/pages/login_page.dart';
import 'package:modern_transportation/pages/password_reset_page.dart';
import 'package:modern_transportation/pages/sign_up_page.dart';
import 'package:modern_transportation/pallete.dart';

void main() {
  final authRepository = AuthRepository(baseUrl: 'https://api.odatransportation.com');
  
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
          title: 'Oda Transportation',
          debugShowCheckedModeBanner: false, // Disable the debug banner
          theme: ThemeData(
            scaffoldBackgroundColor: Pallete.backgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: Pallete.backgroundColor,
              foregroundColor: Pallete.textColor,
              elevation: 0,
            ),
          ),
          
          // Use onGenerateRoute to handle dynamic routes (like reset password)
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
            '/add-credit-card-page': (context) => const AddCreditCardPage(),
            '/credit-card-page': (context) => const CreditCardPage(),
            '/home-page': (context) => const LoginScreen(),
            '/book-taxi-page': (context) => const BookTaxiPage(),
            '/ride-details-page': (context) => const RideDetailsPage(),
            '/rate-driver-page': (context) => const RateDriverPage(),
            '/phone-reg-page': (context) => const PhoneRegPage(),
            '/login-page': (context) => const LoginScreen(),
            '/forgot-password-page': (context) => const ForgotPasswordScreen(),
            '/sign-up-page': (context) => const SignUpScreen(),
            '/map-page': (context) => const HomeScreen(),
            '/otp-page': (context) => const OtpPage(),
            '/reset-password-page': (context) => const ResetPasswordScreen(resetToken: '',),
            '/promo-code-page': (context) => const PromoCodePage(),
            '/ride-history-page': (context) => const RideHistoryPage(),
            '/settings-page': (context) => const SettingsPage(),
            '/support-page': (context) => const SupportPage(),
          },
          
          // Define the initial route (login screen)
          home: const PhoneRegPage(),
        ),
      ),
    );
  }
}

/// Main App
// import 'package:flutter/material.dart';
//      import 'package:google_maps_flutter/google_maps_flutter.dart';

//      void main() => runApp(MyApp());

//      class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//        @override
//        Widget build(BuildContext context) {
//          return MaterialApp(
//            home: Scaffold(
//              appBar: AppBar(
//                title: const Text('Google Maps in Flutter'),
//              ),
//              body: const GoogleMap(
//                initialCameraPosition: CameraPosition(
//                  target: LatLng(37.7749, -122.4194),
//                  zoom: 10,
//                ),
//              ),
//            ),
//          );
//        }
     
//      }
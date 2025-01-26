// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:modern_transportation/bloc/auth_bloc.dart';
// import 'package:modern_transportation/login_screen.dart';
// import 'package:modern_transportation/widgets/gradient_button.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthInitial) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const LoginScreen(),
//               ),
//               (route) => false,
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Center(
//             child: Column(
//               children: [
//                 Text((state as AuthSuccess).uid),
//                 GradientButton(
//                   label: 'Log in',
//                   onPressed: () {
//                     context.read<AuthBloc>().add(AuthLogoutRequested());
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGoogleplex = LatLng(9.02063, 38.75002);
  @override
  Widget build(BuildContext content) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGoogleplex,
          zoom: 13,
        ),
  
      ),
    );
  }
}

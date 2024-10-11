// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_locker_windows/routes/route_constants.dart';
// import 'package:smart_locker_windows/themes/theme_config.dart';
// import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';

// class LoginAuthenticate extends StatefulWidget {
//   const LoginAuthenticate({Key? key}) : super(key: key);

//   @override
//   State<LoginAuthenticate> createState() => _LoginAuthenticateState();
// }

// class _LoginAuthenticateState extends State<LoginAuthenticate> {
//   @override
//   void initState() {
//     navigateOnDelay();
//     super.initState();
//   }

//   navigateOnDelay() async {
//     await Future.delayed(const Duration(seconds: 3));

//     if (BlocProvider.of<UserModelBloc>(context)
//             .state
//             .userModel
//             ?.userRoleCodes ==
//         "SL_ADMIN") {
//       // Navigator.pushNamed(
//       //   context,
//       //   INITIAL_ADMIN_SCREEN_ROUTE,
//       // );
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         INITIAL_ADMIN_SCREEN_ROUTE,
//         ModalRoute.withName('/initialAdminScanScreen'),
//       );
//       // Navigator.pushNamedAndRemoveUntil(
//       //   context,
//       //   SERVICE_INTERFACE_SCREEN_ROUTE,
//       //   ModalRoute.withName('/serviceInterfaceScreen'),
//       // );
//     } else {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         INITIAL_EMPLOYEE_SCREEN_ROUTE,
//         ModalRoute.withName('/initialEmployeeScreen'),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/img/Employee ID Scan.jpg',
//             fit: BoxFit.cover,
//           ),

//           //
//           Positioned(
//             top: 20.0,
//             left: 20.0,
//             child: Image.asset(
//               'assets/img/Logo_emirates.png',
//               height: 120,
//               width: 120,
//             ),
//           ),

//           //
//           Positioned(
//             bottom: -4.0,
//             right: 15.0,
//             child: Card(
//               color: THEME_COLOR,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(70.0),
//                   topRight: Radius.circular(70.0),
//                   bottomLeft: Radius.circular(2.0),
//                   bottomRight: Radius.circular(2.0),
//                 ),
//               ),
//               child: SizedBox(
//                 width: 340.0,
//                 height: 700.0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 50),

//                       //
//                       const Text(
//                         'Welcome to ',
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: Colors.white,
//                         ),
//                       ),

//                       //
//                       const SizedBox(height: 15),

//                       //
//                       const Text(
//                         'Kiosk Smart Locker',
//                         style: TextStyle(
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),

//                       //
//                       const SizedBox(height: 20.0),

//                       //
//                       Image.asset(
//                         'assets/img/lock.png',
//                         // 'assets/lock-removebg-preview.png',
//                         width: 150.0,
//                         height: 150.0,
//                       ),

//                       //
//                       const SizedBox(height: 40),

//                       //
//                       const Text(
//                         'Authenticated',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.white,
//                         ),
//                       ),

//                       //
//                       Image.asset(
//                         "assets/img/authenticated.png",
//                         height: 180,
//                         width: 180,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

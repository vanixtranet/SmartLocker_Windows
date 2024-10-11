// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_locker_windows/themes/theme_config.dart';
// import 'package:smart_locker_windows/ui/widgets/snack_bar.dart';

// import '../../../data/bloc/authentication_bloc/authentication_bloc.dart';
// import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
// import '../../../data/models/user_models/user_model.dart';
// import 'package:gif_view/gif_view.dart';
// import '../../../routes/route_constants.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isLoginVisible = true;
//   bool isCardScannerVisible = false;
//   bool isLoadingVisible = false;

//   int invalidLoginCount = 0;

//   TextEditingController userIdController = TextEditingController();

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
//                       const SizedBox(
//                         height: 50,
//                       ),

//                       //
//                       const Text(
//                         'Welcome to ',
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),

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
//                       SizedBox(height: isLoginVisible ? 30.0 : 10.0),

//                       //
//                       Image.asset(
//                         'assets/img/lock.png',
//                         // 'assets/lock-removebg-preview.png',
//                         width: isLoginVisible ? 130.0 : 100.0,
//                         height: isLoginVisible ? 130.0 : 100.0,
//                       ),
//                       const SizedBox(height: 40.0),

//                       //
//                       loadingWidget(),

//                       //
//                       // Visibility(
//                       //   visible: isCardScannerVisible,
//                       //   child: scannerWidget(),
//                       // ),

//                       //
//                       Visibility(visible: isLoginVisible, child: loginWidget()),
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

//   Widget loadingWidget() {
//     return Column(
//       children: [
//         Visibility(
//           visible: isLoadingVisible,
//           child: const Text(
//             "Please wait till you are\nauthenticated..",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               // fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Visibility(
//           visible: isLoadingVisible,
//           child: GifView.asset(
//             'assets/img/loader.gif',
//             height: 180,
//             width: 180,
//             frameRate: 15, // default is 15 FPS
//           ),
//         ),
//       ],
//     );
//   }

//   Widget loginWidget() {
//     return Column(
//       children: [
//         TextField(
//           controller: userIdController,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: const BorderSide(
//                 width: 3,
//               ),
//             ),
//             labelText: 'User Id:',
//             labelStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),

//         //
//         const SizedBox(height: 16),

//         //
//         ElevatedButton(
//           onPressed: () {
//             loginButtonOnPressed();
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.yellow,
//             minimumSize: const Size(200.0, 50.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//           ),
//           child: const Text(
//             'Login',
//             style: TextStyle(fontSize: 20.0, color: Colors.black),
//           ),
//         ),

//         //
//         const SizedBox(height: 15),

//         //
//         const Text(
//           'Please Enter your\nEmployee Id',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 18.0,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   // Widget scannerWidget() {
//   //   return Column(
//   //     children: [
//   //       Image.asset(
//   //         "assets/img/scanner.png",
//   //         height: 150,
//   //         width: 150,
//   //       ),

//   //       //
//   //       const SizedBox(height: 15),

//   //       //
//   //       const Text(
//   //         'We are scanning your Card.',
//   //         style: TextStyle(
//   //           fontSize: 20.0,
//   //           color: Colors.white,
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   loginButtonOnPressed() async {
//     if (userIdController.text.isEmpty) {
//       return displaySnackBar(
//         context: context,
//         text: 'Please Enter User Id',
//         fontSize: 24,
//       );
//     }

//     // setState(() {
//     //   isLoginVisible = false;
//     //   isCardScannerVisible = true;
//     // });
//     // await Future.delayed(const Duration(seconds: 2));
//     FocusScope.of(context).requestFocus(FocusNode());
//     setState(() {
//       // isCardScannerVisible = false;
//       isLoadingVisible = true;
//       isLoginVisible = false;
//     });

//     // await Future.delayed(const Duration(seconds: 5));

//     loginRequest();
//   }

//   loginRequest({
//     String? rfidData,
//   }) async {
//     UserModel? data = await authenticationBloc.authenticateUser(
//       queryparams: {
//         "rfid": userIdController.text,
//       },
//     );
//     // .authenticateUser(queryparams: {"rfid": rfidData ?? "5656"});

//     if (data != null && data.isSuccess == true) {
//       displaySnackBar(
//         context: context,
//         text: 'Login Successful',
//         fontSize: 24,
//       );

//       BlocProvider.of<UserModelBloc>(context).add(
//         UserModelChangeEvent(
//           userModel: data,
//         ),
//       );

//       Navigator.pushReplacementNamed(
//         context,
//         LOGIN_RFID_SCANNER_SCREEN_ROUTE,
//       );

//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => const LoginAuthenticate(),
//       //   ),
//       // );
//     } else {
//       invalidLoginCount++;
//       setState(() {
//         isLoadingVisible = false;
//         isLoginVisible = true;
//       });
//       displaySnackBar(
//         context: context,
//         text: data.error ?? 'Something went wrong, please try again later.',
//       );

//       if (invalidLoginCount == 3) {
//         postSendUnauthorizedAccessAlert();
//       }
//     }
//   }

//   postSendUnauthorizedAccessAlert() async {
//     await authenticationBloc.postSendUnauthorizedAccessAlert(
//       queryparams: {},
//     );
//   }
// }

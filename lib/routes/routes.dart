import 'package:flutter/material.dart';
import 'package:smart_locker_windows/ui/screens/employee_bin_screens/bin_return_screen.dart';
import 'package:smart_locker_windows/ui/screens/login_screen/authenticate.dart';
import 'package:smart_locker_windows/ui/screens/employee_bin_screens/bin_print_barcode_screen.dart';
import 'package:smart_locker_windows/ui/screens/locker_screens/locker_selections/any_locker_screen.dart';
import 'package:smart_locker_windows/ui/screens/locker_screens/locker_selections/barcode_message_screen.dart';
import 'package:smart_locker_windows/ui/screens/locker_screens/locker_selections/locker_selection_screen.dart';
import 'package:smart_locker_windows/ui/screens/locker_screens/locker_selections/store_return_screen.dart';
import 'package:smart_locker_windows/ui/screens/locker_screens/locker_selections/locker_return_collect_option_screen.dart';
import 'package:smart_locker_windows/ui/screens/scan_barcode_screen/scan_barcode_screen.dart';
import 'package:smart_locker_windows/ui/screens/employee_screens/initial_employee_scan_screen.dart';
import 'package:smart_locker_windows/ui/screens/service_interface_screen/service_interface_screen.dart';
import '../ui/screens/alert_screen/alert_screen.dart';
import '../ui/screens/employee_bin_screens/bin_open_screen.dart';
import '../ui/screens/admin_bin_screens/bin_admin_key_screen.dart';
import '../ui/screens/admin_bin_screens/bin_selection_screen.dart';
import '../ui/screens/admin_bin_screens/close_bin_door_screen.dart';
import '../ui/screens/employee_vending_screens/vending_collect_screens.dart';
import '../ui/screens/employee_vending_screens/vending_open_screen.dart';
import '../ui/screens/locker_screens/locker_selections/locker_details_screen.dart';
import '../ui/screens/login_screen/login_rfid_scanner_screen.dart';
import '../ui/screens/service_interface_screen/initial_admin_scan_screen.dart';
import '../ui/screens/thank_you_screen/thankyou_screen.dart';
import '../ui/screens/vending_screens/close_vending_door_screen.dart';
import '../ui/screens/vending_screens/vending_selection_screen.dart';
import 'route_constants.dart';
import 'screen_arguments.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case LOGIN_SCREEN_ROUTE:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );

      case LOGIN_RFID_SCANNER_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const LoginRfidScannerScreen(),
        );

      // case LOGIN_AUTHENTICATE_SCREEN_ROUTE:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginAuthenticate(),
      //   );

      case THANK_YOU_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const ThankyouScreen(),
        );

      case BIN_SELECTION_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const BinSelectionScreen(),
        );

      case BIN_ADMIN_KEY_ROUTE:
        final args = routeSettings.arguments as ScreenArguments?;
        return MaterialPageRoute(
          builder: (_) => BinAdminKeyScreen(
            isVendingScreen: args?.bool1 ?? false,
          ),
        );

      case CLOSE_BIN_DOOR_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const CloseBinDoorScreen(),
        );

      case VENDING_SELECTION_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const VendingSelectionScreen(),
        );

      case CLOSE_VENDING_DOOR_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const CloseVendingDoorScreen(),
        );

      case ALERT_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const AlertScreen(),
        );

      case ANY_LOCKER_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const AnyLockerSelectionScreen(),
        );

      case BARCODE_MESSAGE_SCREEN_ROUTE:
        final args = routeSettings.arguments as ScreenArguments?;
        return MaterialPageRoute(
          builder: (_) => BarcodeMessageScreen(
            isEmployee: args?.bool1 ?? false,
          ),
        );

      case LOCKER_DETAIL_SCREEN_ROUTE:
        final args = routeSettings.arguments as ScreenArguments?;
        return MaterialPageRoute(
          builder: (_) => LockerDetailsScreen(
            isReturn: args?.bool1 ?? false,
            lockerDetail: args?.lockerDetail,
          ),
        );

      case LOCKER_SELECTION_SCREEN_ROUTE:
        final args = routeSettings.arguments as ScreenArguments?;
        return MaterialPageRoute(
          builder: (_) => LockerSelectionScreen(
            isReturn: args?.bool1 ?? false,
          ),
        );

      case STORE_RETURN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const StoreRetunScreen(),
        );

      case LOCKER_RETURN_COLLECT_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const LockerReturnCollectScreen(),
        );

      case SCAN_BARCODE_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const ScanBarcodeScreen(),
        );

      case INITIAL_EMPLOYEE_SCREEN_ROUTE:
        final args = routeSettings.arguments as ScreenArguments?;
        return MaterialPageRoute(
          builder: (_) => InitialEmployeeScanScreen(
            isCollect: args?.bool1 ?? false,
          ),
        );

      // case SCAN_QR_SCREEN_ROUTE:
      //   return MaterialPageRoute(
      //     builder: (_) => const ScanQrScreen(),
      //   );

      case SERVICE_INTERFACE_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const ServiceInterfaceScreen(),
        );

      case AUTHENTICATE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const Authenticate(),
        );

      case BIN_RETURN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const BinReturnScreen(),
        );

      case BIN_PRINT_BARCODE_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const BinPrintBarcodeScreen(),
        );

      case BIN_OPEN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const BinOpenScreen(),
        );

      case VEDNING_OPEN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const VendingOpenScreen(),
        );

      case VENDING_COLLECT_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const VendingCollectScreen(),
        );

      case INITIAL_ADMIN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const InitialAdminScanScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                "Error 404: No route defined with this name: ${routeSettings.name}.",
              ),
            ),
          ),
        );
    }
  }
}

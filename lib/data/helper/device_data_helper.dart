import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceDataHelper {

  // Device info plugin to get the serial number from android device attached to the locker unit
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

   Future<Map<String, dynamic>> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    // if (!mounted) return;

    _deviceData = deviceData;

    return _deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'serialNumber': build.serialNumber,
    };
  }
}
import 'dart:async';
import 'dart:ui';

import 'package:background_locator/location_dto.dart';

import 'LocationCallback.dart';

class LocationCallbackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    await LocationCallbackRepo().init(params);
  }

  static Future<void> disposeCallback() async {
    await LocationCallbackRepo().dispose();
    
  }

  static Future<void> callback(LocationDto locationDto) async {
    await LocationCallbackRepo().callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }
}

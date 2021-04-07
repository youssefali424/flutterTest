import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';

// import 'LocationCallback.dart';
import 'LocationCallbackHandler.dart';

class GpsLocator {
  static const String _isolateName = "LocatorIsolate";
  static ReceivePort port = ReceivePort();
  static bool isInitiated = false;

  static Future<bool> initPlugin(void Function(LocationDto) callback) async {
    if (isInitiated) {
      if (callback != null) {
        addCallback(callback);
      }
      return true;
    }
    var registered =
        IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    if (!registered) {
      IsolateNameServer.removePortNameMapping(_isolateName);
      IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    }
    try {
      await BackgroundLocator.initialize();
      isInitiated = true;
      if (callback != null) {
        addCallback(callback);
      }
      return true;
    } catch (ex) {
      return false;
    }
  }

  static addCallback(void Function(LocationDto) callback) {
    if (!isInitiated) {
      throw ("plugin not initialized");
    }
    port.listen((dynamic data) {
      // do something with data
      callback(data as LocationDto);
    });
  }

  static Future<BackgroundLocatorStatus> startLocationService(
      {void Function(LocationDto) callback}) async {
    var permission = await checkLocationPermission();
    if (!permission) {
      return BackgroundLocatorStatus.PrmissionFailed;
    }

    if (!isInitiated) {
      isInitiated = await initPlugin(callback);
      if (!isInitiated) {
        return BackgroundLocatorStatus.InitFailed;
      }
    }
    if (await isRunning) {
      return BackgroundLocatorStatus.Started;
    }
    try {
      BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
          initCallback: LocationCallbackHandler.initCallback,
          initDataCallback: Map(),
          disposeCallback: LocationCallbackHandler.disposeCallback,
          autoStop: false,
          iosSettings: IOSSettings(
              accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
          androidSettings: AndroidSettings(
              accuracy: LocationAccuracy.NAVIGATION,
              interval: 5,
              distanceFilter: 0,
              androidNotificationSettings: AndroidNotificationSettings(
                  notificationChannelName: 'Location tracking',
                  notificationTitle: 'Start Location Tracking',
                  notificationMsg: 'Track location in background',
                  notificationBigMsg:
                      'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                  notificationIcon: '',
                  notificationIconColor: Colors.grey,
                  notificationTapCallback:
                      LocationCallbackHandler.notificationCallback)));
      return BackgroundLocatorStatus.Started;
    } catch (ex) {
      return BackgroundLocatorStatus.RegisterFailed;
    }
  }

  static Future<bool> checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
        break;
      case PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  static Future<bool> get isRunning async =>
      await BackgroundLocator.isServiceRunning();

  static Future<void> stop() async {
    if (await isRunning) {
      await LocationCallbackHandler.disposeCallback();
    }
  }
}

enum BackgroundLocatorStatus {
  Started,
  PrmissionFailed,
  InitFailed,
  RegisterFailed,
  Unknown,
  Stopped
}

import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';

// import 'file_manager.dart';

class LocationCallbackRepo {
  static LocationCallbackRepo _instance = LocationCallbackRepo._();

  LocationCallbackRepo._();

  factory LocationCallbackRepo() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  int _count = -1;

  Future<void> init(Map<dynamic, dynamic> params) async {
    print("***********Init callback handler");
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> dispose() async {
    print("***********Dispose callback handler");
    print("$_count");
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
    IsolateNameServer.removePortNameMapping(LocationCallbackRepo.isolateName);
    BackgroundLocator.unRegisterLocationUpdate();
  }

  Future<void> callback(LocationDto locationDto) async {
    print('$_count location in dart: ${locationDto.toString()}');
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDto);
    _count++;
  }
}

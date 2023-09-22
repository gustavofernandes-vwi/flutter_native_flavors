import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_flavors_platform_interface.dart';

/// An implementation of [FlutterNativeFlavorsPlatform] that uses method channels.
class MethodChannelFlutterNativeFlavors extends FlutterNativeFlavorsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_flavors');

  @override
  Future<String?> getFlavorName() async {
    final version = await methodChannel.invokeMethod<String>('getFlavorName');
    return version;
  }
}

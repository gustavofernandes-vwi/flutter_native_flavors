import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_flavors_method_channel.dart';

abstract class FlutterNativeFlavorsPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeFlavorsPlatform.
  FlutterNativeFlavorsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeFlavorsPlatform _instance = MethodChannelFlutterNativeFlavors();

  /// The default instance of [FlutterNativeFlavorsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeFlavors].
  static FlutterNativeFlavorsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeFlavorsPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeFlavorsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getFlavorName() {
    throw UnimplementedError('getFlavorName() has not been implemented.');
  }
}

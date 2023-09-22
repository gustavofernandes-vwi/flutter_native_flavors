import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_flavors/flutter_native_flavors.dart';
import 'package:flutter_native_flavors/flutter_native_flavors_platform_interface.dart';
import 'package:flutter_native_flavors/flutter_native_flavors_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeFlavorsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeFlavorsPlatform {

  @override
  Future<String?> getFlavorName() => Future.value('beta');
}

void main() {
  final FlutterNativeFlavorsPlatform initialPlatform = FlutterNativeFlavorsPlatform.instance;

  test('$MethodChannelFlutterNativeFlavors is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeFlavors>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeFlavors flutterNativeFlavorsPlugin = FlutterNativeFlavors();
    MockFlutterNativeFlavorsPlatform fakePlatform = MockFlutterNativeFlavorsPlatform();
    FlutterNativeFlavorsPlatform.instance = fakePlatform;

    expect(await FlutterNativeFlavors.getFlavorName(), 'beta');
  });
}

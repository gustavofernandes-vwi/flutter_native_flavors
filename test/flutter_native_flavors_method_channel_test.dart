import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_flavors/flutter_native_flavors_method_channel.dart';

void main() {
  MethodChannelFlutterNativeFlavors platform = MethodChannelFlutterNativeFlavors();
  const MethodChannel channel = MethodChannel('flutter_native_flavors');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getFlavorName(), '42');
  });
}

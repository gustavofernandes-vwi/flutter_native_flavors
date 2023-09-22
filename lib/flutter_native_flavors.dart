
import 'package:flutter/widgets.dart';

import 'flutter_native_flavors_platform_interface.dart';

class FlutterNativeFlavors {
  static Future<String?> getFlavorName() {
    return FlutterNativeFlavorsPlatform.instance.getFlavorName();
  }
}

class FlavorConfig<T extends Object> {
  final Map<String,T> configOptions;

  FlavorConfig(this.configOptions);

  Future<T?> getRunningFlavorConfig({String? defaultFlavor}) async {
    final String? flavorName = (await FlutterNativeFlavors.getFlavorName()) ?? defaultFlavor;
    
    return configOptions[flavorName];
  }

  static InheritedFlavorConfig<T> inject<T extends Object>({required Widget child, T? config}) => InheritedFlavorConfig<T>(config: config, child: child);
  static T? getFromContext<T extends Object>(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedFlavorConfig<T>>()?.config;
}

class InheritedFlavorConfig<T extends Object> extends InheritedWidget {
  final T? config;

  const InheritedFlavorConfig({
    this.config,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

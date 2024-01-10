#ifndef FLUTTER_PLUGIN_FLUTTER_NATIVE_FLAVORS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_NATIVE_FLAVORS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_native_flavors {

class FlutterNativeFlavorsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterNativeFlavorsPlugin();

  virtual ~FlutterNativeFlavorsPlugin();

  // Disallow copy and assign.
  FlutterNativeFlavorsPlugin(const FlutterNativeFlavorsPlugin&) = delete;
  FlutterNativeFlavorsPlugin& operator=(const FlutterNativeFlavorsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_native_flavors

#endif  // FLUTTER_PLUGIN_FLUTTER_NATIVE_FLAVORS_PLUGIN_H_

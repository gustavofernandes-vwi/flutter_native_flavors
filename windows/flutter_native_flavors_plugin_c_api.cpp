#include "include/flutter_native_flavors/flutter_native_flavors_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_native_flavors_plugin.h"

void FlutterNativeFlavorsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_native_flavors::FlutterNativeFlavorsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

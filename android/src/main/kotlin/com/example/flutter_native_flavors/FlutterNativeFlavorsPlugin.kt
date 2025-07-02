package com.example.flutter_native_flavors

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context

/** FlutterNativeFlavorsPlugin */
class FlutterNativeFlavorsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var applicationContext: Context? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_native_flavors")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getFlavorName") {
      try {
        val flavor = getFlavorName(applicationContext!!.packageName)

        result.success(flavor)
      }
      catch(exception: Exception) {
        result.success("exception ${exception}")
        result.success(null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = null
    channel.setMethodCallHandler(null)
  }

  private fun getFlavorName(fieldName: String): Any? {
    var packageName = fieldName

    try {
        val packageClass = Class.forName("${packageName}.BuildConfig")
        val flavor = packageClass.getField("FLAVOR")

        return flavor.get(null) ?: "null"
    } catch (e: ClassNotFoundException) {
        // Field retrieval failed, try removing the last segment of the package name
        val lastDotIndex = packageName.lastIndexOf('.')
        
        if (lastDotIndex != -1) {
            packageName = packageName.substring(0, lastDotIndex)

            return getFlavorName(packageName)
        }
    } catch (e: NoSuchFieldException) {
        // Field not found, handle accordingly
        return null
    } catch (e: IllegalAccessException) {
        // Access to field failed, handle accordingly
        return null
    }

    return null
  }
}

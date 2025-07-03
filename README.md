# Flutter Native Flavors

A utility to help retrieve the native flavor running and changing settings based on this.

## Usage

Getting only the running flavor name:

```dart
final String? flavorName = await FlutterNativeFlavors.getFlavorName();
```

Creating different configs and retrieving them based on running flavor:

```dart
// AppConfig is totally up to you how to implement and how many configs you wanna have
class AppConfig {
  final String flavor;
  final String apiUrl;

  AppConfig({
    required this.flavor,
    required this.apiUrl,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flavors = FlavorConfig({
    'prod': AppConfig(
      flavor: 'prod',
      apiUrl: 'https://production.api.example.com',
    ),
    'beta': AppConfig(
      flavor: 'beta',
      apiUrl: 'https://beta.api.example.com',
    ),
  });

  // When you're implementing this plugin, it's reccomended not to use a default option to better detect configuration errors
  final AppConfig? config = await flavors.getRunningFlavorConfig(defaultFlavor: 'prod');

  runApp(MyApp(
    config: config!, // To avoid crashes, only force with "!" if you provided a valid default option above
  ));
}
```

## Getting Started

### iOS Setup

1. Open your Flutter project in Xcode by navigating to `ios/Runner.xcworkspace`.
2. In Xcode, select your application target (Runner) and go to the **Build Settings** tab.
3. Under the **User-Defined** section, add a new build setting called `APP_FLAVOR` and set it to the desired flavor value for each scheme.
4. Open the `Info.plist` file located in the `ios/Runner` directory.
5. Add a new entry to the Information Property List with the key `App - Flavor` and the value `$(APP_FLAVOR)`. This will ensure that the flavor value is accessible in the Info.plist file.
6. Save the `Info.plist` file.
7. Build and run your application using the desired scheme and flavor.

### Android Setup

1. Open your Flutter project in Android Studio.
2. Locate the `android/app/build.gradle` file.
3. Inside the `android` block, ensure to enable `buildConfig` and that the `defaultConfig` section contains the following line:
    ```groovy
    android {
        namespace "com.example.myapp" // Add this line. Replace with your namespace
        // ...
        buildFeatures {
            buildConfig true // Add this flag
        }
        // ...
        defaultConfig {
            // ...
            applicationId "com.example.myapp" // Add this config. Replace with your applicationId; make sure it's similar to namespace
            // ...
        }
    }
    ```
    The applicationId should match the package name defined in your AndroidManifest.xml file.

4. To add flavors, add the following lines to the android block:
    ```groovy
    flavorDimensions "default"

    productFlavors {
        beta {
            applicationIdSuffix ".beta"  // com.example.myapp.beta
        }
        prod {
            applicationIdSuffix ".prod"  // com.example.myapp.prod
        }
    }
    ```
Customize the flavor names (dev and prod) and the applicationIdSuffixes (.dev and .prod) to match your desired flavors.

## Making the config available on different parts of the app

After retrieving your config object, you can use anything you already have to provide dependencies
to your app (dependency injection, provider, get_it, etc.).

The package includes flutter default inhereted widget shorthand functions, if you want to use it.

**Setting up:**

```dart
// Wrapping MaterialApp with this will provide the config for the entire app
return FlavorConfig.inject<AppConfig>(
  config: appConfig,
  child: MaterialApp(
    home: ///...
  ),
);
```

**Retrieving:**

```dart

// On AppConfig class, add this:
class AppConfig {
    // ...

    static AppConfig of(BuildContext context) => FlavorConfig.getFromContext(context)!
}

// Then on any widget you can use:
AppConfig.of(context)
```

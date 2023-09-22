import 'package:flutter/material.dart';

import 'package:flutter_native_flavors/flutter_native_flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flavors = FlavorConfig({
    'prod': AppConfig(flavor: 'prod', apiUrl: 'https://production.api.example.com'),
    'beta': AppConfig(flavor: 'beta', apiUrl: 'https://beta.api.example.com'),
  });

  // When you're implementing this plugin, it's reccomended not to use a default option to better detect configuration errors
  final AppConfig? config = await flavors.getRunningFlavorConfig(defaultFlavor: 'prod');

  runApp(MyApp(
    config: config!, // To avoid crashes, only force with "!" if you provided a valid default option above
  ));
}

class AppConfig {
  final String flavor;
  final String apiUrl;

  AppConfig({
    required this.flavor,
    required this.apiUrl,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({required this.config, super.key});

  final AppConfig config;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Running on flavor: ${widget.config.flavor}\n'),
              Text('Api url: ${widget.config.apiUrl}\n'),
            ],
          ),
        ),
      ),
    );
  }
}

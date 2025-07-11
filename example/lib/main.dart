import 'dart:async';

import 'package:avlcweb/avlcweb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _avlcwebPlugin = AvlcWeb();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _avlcwebPlugin.getPlatformVersion() ?? 'Unknown platform version';
      _avlcwebPlugin.initialize(
        appId: "your_app_id",
        appSecret: "your_app_secret",
        onInitialize: (isInitialized, {error}) {},
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AVLCWeb'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Phone Number",
                enabled: true,
                enabledBorder: OutlineInputBorder(),
                filled: false,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _avlcwebPlugin.sendOtp({"phone": phoneNumberController.text}, (p0) {});
              },
              child: const Text("Send Otp!"),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: otpController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter OTP",
                enabled: true,
                enabledBorder: OutlineInputBorder(),
                filled: false,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _avlcwebPlugin.verifyOtp({
                  "phone": phoneNumberController.text,
                  "otp": otpController.text,
                }, (p0) {});
              },
              child: const Text("Verify Otp!"),
            ),
          ],
        ),
      ),
    );
  }
}

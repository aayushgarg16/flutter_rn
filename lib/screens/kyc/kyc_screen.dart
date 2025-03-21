import 'package:flutter/material.dart';
import 'package:flutter_rn_app/react_native_android_widget.dart';

class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ReactNativeAndroidWidget(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReactNativeAndroidWidget extends StatelessWidget {
  const ReactNativeAndroidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const viewType = 'ReactNativeView';
    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'screen': 'HomeScreen',
        'userId': '12345',
        'name': 'Aayush',
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

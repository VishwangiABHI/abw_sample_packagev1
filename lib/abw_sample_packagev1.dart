library abw_sample_packagev1;

import 'package:abw_sample_packagev1/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertBox {
  static MaterialApp showCustomAlertBox({required BuildContext context}) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WebView());
  }
}

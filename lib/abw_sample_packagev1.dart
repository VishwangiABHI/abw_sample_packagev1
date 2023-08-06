library abw_sample_packagev1;

import 'package:abw_sample_packagev1/webview.dart';
import 'package:flutter/material.dart';

class CustomAlertBox {
  static dhaABW(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebView()));
  }
}
